extends: default.liquid

title: BYO Standard&#58; An Explorer's Guide to Compiler Plugins
draft: false
date: 10 Jul 2018 20:00:00 +0000
calendardate: July 10, 2018
path: 2018/byo-standard

---

The Rust programming language provides powerful guarantees around memory and
thread safety. It also exposes all the knobs required for implementing custom
rules, enabling a project to make additional guarantees and enforce opinions on
best practice. Embedded standards are very opinionated about software
practices—like using floating point values as loop counters or the number of
possible exit points of a function—and Rust’s defaults don’t prevent every
runtime panic or potential to crash (for example, recursion that goes too deep
and overflows the stack).

For PolySync, a runtime panic means the potential for an unsafe situation on the
road, and with that in mind, we’ve explored ways to restrict that potential. Of
course, we aren’t the only ones thinking about ways to improve the quality of
code at compile time by enforcing the right rules for the job. Active projects
like [rust-clippy](https://github.com/rust-lang-nursery/rust-clippy) are working
to do that too by providing lints to supplement the `rustc` defaults.

In this post we’ll explore how to enforce a rule by prohibiting a practice we’ve
formed an opinion about, the indexing of a vector or an array. Preventing
indexing represents the potential to eliminate runtime panics from stepping out
of bounds.

Lets get started.

## Choosing Your Lint Level

Lint levels allow you to configure the severity of a rule violation with the help of rustc.

* Allow: Acceptable behavior that could be disallowed
* Warn: Discourage at compile time with a warning
* Deny: Compile error that, if necessary, can be bypassed with `#![allow(my_lint_rule)]`
* Forbid: Compile error without exception

One size doesn’t fit all and these decisions should be tailored to your
project’s specific requirements.

A quick warning about “forbid”: it should be used sparingly. Forbidding
everything can prove troublesome, for instance, forbidding calls to `unwrap`.
While it may be feasible to disallow it in your own code, it’s not uncommon for
macros exposed by external crates to hide calls to `unwrap`. Rather than finding
another crate, or rewriting it internally to avoid all calls to `unwrap`, it might
be acceptable to implement warning or deny policies that require an explicit
`allow`.

## Exploring the AST

There are at least two options for exploring a Rust program's AST. The `-Z ast-json`
flag passed to rustc helps with getting a feel for the general look
and structure of the AST. Using it looks like this:

<pre>
<code class='bash'>rustc src/main -Z ast-json
</code>
</pre>

This post uses print statements as they provide context about when the data
we’re looking for is accessible (i.e. is `EarlyLintPass` or `LateLintPass` right
for me?). Because the `syntax::ast` types implement `Debug`, they also provided type
information that can be a little more parsable.

First, make sure you're using the nightly toolchain:

<pre>
<code class='bash'>rust default nightly
</code>
</pre>

Now setup a clean linting crate, here named `customlints`:

<pre>
<code class='bash'>cargo init customlints --lib
</code>
</pre>

Next, we’ll do some setup in the `customlints/src/lib.rs` file.

<pre>
<code class='rust'>#![feature(plugin_registrar)]
#![feature(box_syntax, rustc_private)]
#![feature(macro_vis_matcher)]

#[macro_use]
extern crate rustc;
extern crate rustc_plugin;
extern crate syntax;
extern crate syntax_pos;

use rustc::hir;
use rustc::lint::{EarlyContext, EarlyLintPassObject, LateContext, LateLintPassObject, LintArray, LintContext, LintPass};
use rustc_plugin::Registry;
use syntax::ast;

struct EarlyPass;
struct LatePass;

impl LintPass for LatePass {
   fn get_lints(&self) -> LintArray {
       lint_array!() // We'll get to this later, kind of...
   }
}

impl LintPass for EarlyPass` {
   fn get_lints(&self) -> LintArray {
       lint_array!() // We'll definitely get to this later!
   }
}

#[plugin_registrar]
pub fn register_plugins(reg: &mut Registry) {
   reg.register_early_lint_pass(box EarlyPass as EarlyLintPassObject);
   reg.register_late_lint_pass(box LatePass as LateLintPassObject);
}
</code>
</pre>

Now, we can implement `rustc::lint::EarlyLintPass` and
`rustc::lint::LateLintPass` for some preliminary examination.

<pre>
<code class='rust'>impl rustc::lint::EarlyLintPass for EarlyPass {
   fn check_expr(&mut self, cx: &EarlyContext, expr: &ast::Expr) {
       println!("Early pass, expression: {:?}", expr);
   }
}

impl<'a, 'tcx> rustc::lint::LateLintPass<'a, 'tcx> for LatePass {
   fn check_expr(&mut self, cx: &LateContext<'a, 'tcx>, expr: &'tcx hir::Expr) {
       println!("Late pass, expression: {:?}", expr);
   }
}
</code>
</pre>

In order to incorporate this exploratory plugin, we can create another crate, a
`[[bin]]` this time:

<pre>
<code class='bash'>cargo init example --bin
</code>
</pre>

Then point to our linter in that project's Cargo.toml. (Note the `optional = true`
, we’ll revisit that later.):

<pre>
<code class='toml'>[dependencies.customlints]
path = "/path/to/customlints"
optional = true
</code>
</pre>

Next, we can fill in the main function:

<pre>
<code class='rust'>#![cfg_attr(feature="customlints", feature(plugin))]
#![cfg_attr(feature="customlints", plugin(customlints))]

fn main() {
   // Initialize a vector containing a single element.
   let x = vec![0;1];
   // Attempt to access the vector's 10th element.
   // This is what we want to prohibit!
   let _a = x[10];
}
</code>
</pre>

Time to build. Note that the dependency on the customlints crate is optional, so it needs to be enabled in the build command:

<pre>
<code class='bash'>cargo build --features "customlints"
</code>
</pre>


Looking closely, we can see what looks like our indexing operation in our output. Here's one:

<pre>
<code class='bash'>Early pass, expression: expr(13: x[10])
</code>
</pre>

And later, another:

<pre>
<code class='bash'>Late pass, expression: expr(13: x[10])
</code>
</pre>

Now, we can modify our print statements in order to unpack the `hir::Expr` a bit more:

<pre>
<code class='rust'>println!("Early pass, expression node: {:?}", expr.node);
</code>
</pre>

To minimize noise, we can comment out our late pass output:

<pre>
<code class='rust'>// println!("Late pass, expression node: {:?}", expr.node);
</code>
</pre>


After building our `[[bin]]` project again, there's some information that looks
promising, the following `Index` type that contains `x` and `10`:

<pre>
<code class='bash'>Early pass, expression node: Index(expr(11: x), expr(12: 10))
</code>
</pre>


## Enforcing a Lint

Using the compiler plugin docs and the docs for `syntax::ast` let's lint the
`Index` type. First, we'll need a few modifications. We’ll begin by declaring
the lint with a `Deny` qualification. This means a program that indexes will
fail to compile, but if necessary, can be allowed with
`#![allow(indexing_lint)]`.

<pre>
<code class='rust'>declare_lint!(INDEXING_LINT, Deny, "Deny indexing operations.");
</code>
</pre>

Then, we'll populate that empty `lint_array` in the `impl LintPass for EarlyPass`
that we mentioned earlier.

<pre>
<code class='rust'>impl LintPass for EarlyPass {
   fn get_lints(&self) -> LintArray {
       lint_array!(INDEXING_LINT)
   }
}
</code>
</pre>

Finally, we can define when our lint occurs (any occurance of the `Index` type)
and the report it provides. Replace that `EarlyPass` print statement as follows
(feel free to remove the references to `LatePass`, we're only going to use
`EarlyPass` from here on out):

<pre>
<code class='rust'>impl rustc::lint::EarlyLintPass for EarlyPass {
   fn check_expr(&mut self, cx: &EarlyContext, expr: &ast::Expr) {
       if let ast::ExprKind::Index(_ , _) = expr.node {
           cx.span_lint(INDEXING_LINT, expr.span, "Indexing operations disallowed!");
       }
   }
}
</code>
</pre>

After building our `[[bin]]` project again, tada!

<pre>
<code class='bash'>error: Indexing operations disallowed!
--> src/main.rs:6:14
  |
6 |     let _a = x[10];
  |              ^^^^^
  |
 = note: #[deny(indexing_lint)] on by default
error: aborting due to previous error
</code>
</pre>

We've implemented a lint.

## Fine Tuning

Now, in an attempt to eliminate unintended side effects, we need to stress the
edges (or even just look for them). For instance, maybe since `let _b = &x[..]`
won't cause a runtime panic we decide to allow its behavior. Let’s add that to
our `[[bin]]` project and build it.

Sure enough, we're denying behavior we've decided we don't want to. By putting
our print statement back we can take another look at some debugging output
(informed by the `syntax::ast::ExprKind`).

<pre>
<code class='bash'>impl rustc::lint::EarlyLintPass for EarlyPass {
   fn check_expr(&mut self, cx: &EarlyContext, expr: &ast::Expr) {
       if let ast::ExprKind::Index(_, ref e) = expr.node {
           println!("Early pass, expression node: {:?}", e.node);
           // cx.span_lint(INDEXING_LINT, expr.span, "Indexing operations disallowed!");
       }
   }
}
</code>
</pre>

That provides the following:

<pre>
<code class='bash'>Early pass, expression node: Lit(Spanned { node: Int(10, Unsuffixed), span: Span { lo: BytePos(167), hi: BytePos(169), ctxt: #0 } })

Early pass, expression node: Range(None, None, HalfOpen)
</code>
</pre>

But what do we do with that? One option is experimenting with our `[[bin]]`
project to see if we can get some more context. This can be achieved with a few
more indexing operations.

Here's the `main` function.

<pre>
<code class='rust'>
fn main() {
   let x = vec![0;1];
   let _a = x[10];
   let _b = &x[10..];
   let _c = &x[..10];
   let _d = &x[10..100];
   let _e = &x[..];
}
</code>
</pre>

Now let's look at the output and see what we can tell.

Because of the `Int(10, Unsuffixed)`, it looks like it corresponds to `let _a = x[10];`:

<pre>
<code class='bash'>Early pass, expression node: Lit(Spanned { node: Int(10, Unsuffixed), span: Span { lo: BytePos(167), hi: BytePos(169), ctxt: #0 } })
</code>
</pre>

Assuming the output occurs in the same order as the indexing operations in the
source code, `&x[..]` probably corresponds to:

<pre>
<code class='bash'>Early pass, expression node: Range(None, None, HalfOpen)
</code>
</pre>

and `&x[10..]` to:

<pre>
<code class='bash'>Early pass, expression node: Range(Some(expr(23: 10)), None, HalfOpen)
</code>
</pre>

and `&x[..10]` to:

<pre>
<code class='bash'>Early pass, expression node: Range(None, Some(expr(30: 10)), HalfOpen)
</code>
</pre>

and `&x[10..100]` to:

<pre>
<code class='bash'>Early pass, expression node: Range(Some(expr(37: 10)), Some(expr(38: 100)), HalfOpen)
</code>
</pre>

The first two values in that `Range` type correspond to `Some` if there is a
position defined and `None` if there isn't. We still need to disallow cases
where there is potential for out-of-bounds access (all but the last case), so
the next step ends up looking like the following:

<pre>
<code class='rust'>impl rustc::lint::EarlyLintPass for `EarlyPass` {
   fn check_expr(&mut self, cx: &EarlyContext, expr: &ast::Expr) {
       if let ast::ExprKind::Index(_, ref e) = expr.node {
           match e.node {
               ast::ExprKind::Range(None, None, _) => (),  // allow &[..]
               _ => {
                   cx.span_lint(INDEXING_LINT, expr.span,
                   "Indexing operations disallowed.");
               }
           }
       }
   }
}
</code>
</pre>

And that did it! All that’s left are the errors for the behavior we decided to
deny.

## Continuing the Work

This lint introduces the potential for some false positives. If it’s possible to
prove at compile time that an index is in range, then our error may be
overstepping its utility. Taking this lint to the next level likely means
allowing indexing in those cases. It may even be feasible to implement a
[MIR processing lint that triggers on all reachable panics](https://github.com/rust-lang-nursery/rust-clippy/issues/2536).
If that existed, a lint
like ours could be phased out entirely.

## How a Stable Product Uses Unstable Lints

Nightly Rust should be backward compatible with the last stable release. That
means a stable project's build success can depend on nightly toolchain linting
without having to worry about something unrelated breaking. Revisiting the setup
we did for our `[[bin]]` example, we see that it allows us to opt out of linting
on a stable toolchain.

First, the `customlints` dependency needs be optional in your Cargo.toml:

<pre>
<code class='toml'>[dependencies.customlints]
path = "/<path>/<to>/customlints"
optional = true
</code>
</pre>

Then, any project that's subject to your custom lints can use `cfg_attr` to
ensure the linting plugin isn't enabled unless the customlints feature is
specified:

<pre>
<code class='rust'>[#![cfg_attr(feature="customlints", feature(plugin))]

#![cfg_attr(feature="customlints", plugin(customlints))]
</code>
</pre>

Using that set up, a nightly build can be invoked with:

<pre>
<code class='bash'>cargo build --features "customlints"
</code>
</pre>

and a stable build with:

<pre>
<code class='bash'>cargo build
</code>
</pre>

## Additional Reading

It can be helpful to start this kind of exploratory effort by looking at other
projects that also implement linting compiler plugins. Some of the places that
have a lot to offer in that area are:

- [The compiler plugin docs](https://doc.rust-lang.org/1.16.0/book/compiler-plugins.html) provide a lot of good context, the basics for
  getting started, and some example code. Using them, you should be able to fill
  in any blanks left in this post's code

- [`rust-clippy` lint implementations](https://github.com/rust-lang-nursery/rust-clippy/tree/master/clippy_lints/src),
  if they don't already offer the lint you want, they may already be doing
  something similar you can pull from.

- [`librustc_lint` implementations](https://github.com/rust-lang/rust/tree/master/src/librustc_lint)
  is another great reference for linting logic that you can pull from.

-  The [My lint-writing workflow](https://llogiq.github.io/2015/06/04/workflows.html) post by [llogiq](https://github.com/llogiq)
   is a great take on a similar approach to lint-writing. Last Word

There are other powerful applications of compiler plugins too. llogiq maintains
a couple of my favorites, [mutagen](https://github.com/llogiq/mutagen)
and [overflower](https://github.com/llogiq/overflower). Mutagen is the
foundation of a [mutation testing](https://en.wikipedia.org/wiki/Mutation_testing)
framework that enables you to evaluate whether
your tests work as they should. Overflower lets you decide what to do when
integer overflow occurs.

Additionally, there is the possibility that others in the community will think
your lints are useful. If you think that's the case, consider running them by
the [rust-clippy](https://github.com/rust-lang-nursery/rust-clippy) team.

While implementing lints can be an illuminating window into the compiler and a
Rust program’s AST, compile time lints are a powerful approach to restricting
program behavior. Because if a program with violations doesn’t compile, it can’t
crash.

_[A version of this post was originally published at [polysync.io/blog](https://polysync.io/blog/byo-standard-an-explorers-guide-to-compiler-plugins).]_