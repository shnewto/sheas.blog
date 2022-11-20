# Implementing FromStr
_January, 2018_  

I recently came across a head-scratcher while working on a personal project
in Rust. I wasn't able to find a ready solution so I worked
something out on my own. I decided to talk through my solution here for a few
reasons. The problem I encountered represents behavior I hadn't seen before,
it's something I learned from and am interested in some conversation around it.
I also think it might help someone who finds themselves in the same boat.

The general problem arose while exploring the `FromStr` trait. I wanted to
implement it for my own type but ran into a pesky issue. Implementing the
`FromStr` trait for my type required that applications using my library include
a `use std::str::FromStr;` to actually use it. This hadn't been my experience
with implementing traits in the past, the `Display` and  `Iterator` traits,
for example, have no such corresponding requirement.

Let's get started with some context. We'll call my library `from_str_example`
and boil things down into the `FromStr` trait as follows.

## Part 1: TypeV1

```rust
use std::str::FromStr;
use std::string::ParseError;

pub struct TypeV1 {
    my_string: String,
}

impl FromStr for TypeV1 {
    type Err = ParseError;

    fn from_str(s: &str) -> Result&lt;Self, Self::Err&gt; {
        Ok(Self { my_string: String::from(s) })
    }
}
```

From here an application that uses my `from_str_example` crate might assume
the following will work (I did).

```rust
extern crate from_str_example;
use from_str_example::TypeV1;

fn main() {
    let var = TypeV1::from_str(
        "Today my winged horse is coming").unwrap();
}
```

But it doesn't work! Trying to compile results in the following errors:

```bash
Compiling myapp v0.1.0 (file:///path/to/my/app)
error[E0599]: no function or associated item named `from_str` found for type `from_str::TypeV1` in the current scope
  --> src/main.rs:18:16
   |
18 |     let test = TypeV1::from_str(
   |                ^^^^^^^^^^^^^^^^ function or associated item not found in `from_str::TypeV1`
   |
   = help: items from traits can only be used if the trait is in scope
help: the following trait is implemented but not in scope, perhaps add a `use` for it:
   |
3  | use std::str::FromStr;
   |

error: aborting due to previous error

error: Could not compile `myapp`.
```

Okay. I trust the compiler. Let's add the `use` it recommends.

```rust
extern crate from_str_example;
use from_str_example::TypeV1;

use std::str::FromStr;

fn main() {
    let var = TypeV1::from_str(
        "Today my winged horse is coming").unwrap();
}
```

And it works! But wait... I don't want to require that `use`. I want `from_str`
to just work for `TypeV1` without requiring anything beyond my library. Okay,
time to rethink. I can just implement my _own_ `from_str` for my type.

## Part 2: TypeV2

So after a revision, that we'll note by using `TypeV2` in this section, we have
the following code in our library.

```rust
use std::string::ParseError;

pub struct TypeV2 {
    my_string: String,
}

impl TypeV2 {
    pub fn from_str(s: &str) -> Result&lt;Self, ParseError&gt; {
        Ok(Self { my_string: String::from(s) })
    }
}
```

And voila, the following works just like I'd hoped...

```rust
extern crate from_str_example;
use from_str_example::TypeV2;

fn main() {
    let var: TypeV2 = TypeV2::from_str(
        "and I am carrying you off to the moon").unwrap();
}
```

Or rather, worked as I'd hoped _briefly_. My next issue arose when I wanted
to write a generic function that expected the `FromStr` trait. Let's reduce
that function to an example. Forgive me the `where` clause, my intent is to
provide as example, some code with meaningful output. If you decide you'd like
to experiment, feel free to remove the `println!`s and revise the
signature to `pub fn generic_print_function<T: FromStr>(_:T)`

```rust
use std::str::FromStr;
use std::fmt::Debug;

pub fn generic_print_function&lt;T: FromStr + Debug&gt;(var: T)
    where &lt;T as std::str::FromStr&gt;::Err: std::fmt::Debug
{
    let from_str_result = T::from_str("Wear your boots if you wander today");
    println!("{:?}", var);
    println!("{:?}", from_str_result);
}
```

Now a user of the `from_str_example` crate is back to compile errors!

```rust
extern crate from_str_example;
use from_str_example::TypeV2;

fn main() {
    let var: TypeV2 = TypeV2::from_str(
        "and I am carrying you off to the moon").unwrap();
    generic_print_function(var);
}
```

The above example results in the following compile error:

```bash
Compiling from_str v0.1.0 (file:///path/to/my/app)
Compiling myapp v0.1.0 (file:///path/to/my/app)
error[E0277]: the trait bound `from_str::TypeV2: std::str::FromStr` is not satisfied
  --> src/main.rs:27:5
   |
27 |     generic_print_function(var);
   |     ^^^^^^^^^^^^^^^^^^^^^^ the trait `std::str::FromStr` is not implemented for `from_str::TypeV2`
   |
   = note: required by `from_str::generic_print_function`

error: aborting due to previous error

error: Could not compile `myapp`.

To learn more, run the command again with --verbose.
```

Well damn, we just removed the implementation of `FromStr`. Desperate times,
they call for desperate measures.

## Part 3: TypeV3

I began the search engine and stack overflow answers dance. I'm not going to
claim that the answer isn't out there but I wasn't able to unearth one and
after enough time I started feeling devious.

Could I just implement `FromStr` _and_ `from_str` unique to my custom type?

As a seasoned C developer I'm accustomed to having to brace for impact when
it feels like I'm going out on a limb. But in Rust land, I've been
empowered by the "hack without fear" mantra. I'm less twitchy and more open to
looking for a fight because I've got the compiler at my back.

Here's my approach using `TypeV3` to indicate the shift.

```rust
use std::str::FromStr;
use std::string::ParseError;
use std::fmt::Debug;

#[derive(Debug)]
pub struct TypeV3 {
    my_string: String,
}

impl TypeV3 {
    pub fn from_str(s: &str) -> Result&lt;Self, ParseError&gt; {
        Ok(Self { my_string: String::from(s) })
    }
}

impl FromStr for TypeV3 {
    type Err = ParseError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        Self::from_str(s)
    }
}

pub fn generic_print_function&lt;T: FromStr + Debug&gt;(var: T)
    where &lt;T as std::str::FromStr&gt;::Err: std::fmt::Debug
{
    let from_str_result = T::from_str("Wear your boots if you wander today");
    println!("{:?}", var);
    println!("{:?}", from_str_result);
}
```

It compiled! Time to see if it works...

```rust
extern crate from_str_example;
use from_str_example::TypeV3;

fn main() {
    let var = TypeV3::from_str(
        "and on the moon we will eat rose petals.").unwrap();
    generic_print_function(var);
}
```

It does work! And in my personal project, this is the approach I took.


Recapping for anyone scanning for the words __fix__ or __success__, implement
the trait `FromStr` _as well as_ a function called `from_str` for your custom
type. This allows you to sidestep the requirement
that a user of your library has to add `use std::str::FromStr;` to their project
to use yours.


For any questions or if you have any insight around the subject of this post, 
or just to say hi, reach out at hello@shnewto.dev.

**UPDATE (01.23.2018):
As noted by [@steveklabnik](https://twitter.com/steveklabnik/status/955877476370206721)
and a handful of users on [/r/rust/](https://www.reddit.com/r/rust/comments/7sgj0a/implementing_fromstr/) the
initial example presented with `TypeV1` will work without an extra `use` statement if
a user opts for `str::parse` rather than using `TypeV1::from_str` directly.

<blockquote class="twitter-tweet" data-conversation="none" data-lang="en"><p lang="en" dir="ltr">you can do this by just implementing `FromStr`! The key is <a href="https://t.co/EAgc0lIPXA">https://t.co/EAgc0lIPXA</a><br><br>you could write this: <a href="https://t.co/kc5ehwett2">https://t.co/kc5ehwett2</a></p>&mdash; Some(@steveklabnik) (@steveklabnik) <a href="https://twitter.com/steveklabnik/status/955877476370206721?ref_src=twsrc%5Etfw">January 23, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
