# The Rust impl period and me
_Some thoughts on participation_

The [Rust programming language](https://www.rust-lang.org) is a self-declared
"systems programming language that runs blazingly fast, prevents segfaults, and
guarantees thread safety." Its
[impl period](https://internals.rust-lang.org/t/the-final-impl-period-newsletter/6408)
is a sort of seasonal community Rust project, or organization of projects.
To paraphrase [Aaron Turon](https://internals.rust-lang.org/t/announcing-the-impl-period-sep-18-dec-17/5676),
it is a time for the Rust community to come together to focus on implementation 
work rather than design/RFC work. 

I've been lucky enough to have had the opportunity to learn Rust in order to 
write it over the last year or so at [PolySync](https://polysync.io/). 
[PolySync](https://polysync.io/) is
[a friend of Rust](https://www.rust-lang.org/en-US/friends.html) and we've been
moving from _using_ Rust to _favoring_ it. My experience with the language at
work drove me to explore the ecosystem independently and to eventually write
Rust for myself, outside of work. I'm happy about a recently published 
crate [bnf](https://crates.io/crates/bnf) (a library for parsing 
Backus–Naur form context-free grammars) and really satisfied with my experience
participating in _the impl period_.

## A quickchecking crate

My part in Rust's _the impl period_ project was work for
[bindgen](https://github.com/rust-lang-nursery/rust-bindgen), a tool that makes
life better for Rust developers that need to use C or C++ by automatically 
generating bindings to existing libraries. It's something I'd used in the 
past for exactly that, writing Rust code that interfaces with existing C. 
It did everything it promised and I'm incredibly glad it's in the ecosystem.

Though not directly affecting any of _bindgen's_ functionality, the 
[quickchecking crate](https://github.com/rust-lang-nursery/rust-bindgen/tree/master/tests/quickchecking)
was written to tackle the
_[Add property based testing with quickcheck](https://github.com/rust-lang-nursery/rust-bindgen/issues/970)_ 
issue and will hopefully help contribute to its growth.
Some of the power of property testing might be boiled 
down to its efficiency in testing an exhaustive set of inputs. One property test 
has the potential to exercise what in other paradigms, often requires an 
impractical or even impossible number of individual tests. 
[quickcheck](https://github.com/BurntSushi/quickcheck) is a Rust package that 
enables writing property tests 
(in the vein of [the original QuickCheck written in Haskell](https://en.wikipedia.org/wiki/QuickCheck)) 
for Rust projects.

My contributions were captured by the following pull requests made to the 
[rust-lang-nursery/rust-bindgen](https://github.com/rust-lang-nursery/rust-bindgen) 
GitHub repository:

* [Property testing with quickcheck](https://github.com/rust-lang-nursery/rust-bindgen/pull/1159)
* [Quickchecking crate CLI](https://github.com/rust-lang-nursery/rust-bindgen/pull/1177)
* [Enable Cargo features for quickchecking crate](https://github.com/rust-lang-nursery/rust-bindgen/pull/1180)

I count my experience as a success. Mostly because three PRs were
merged and the corresponding issues closed and little bit because the 
crate was noticed by [@steveklabnik](https://twitter.com/steveklabnik) 
(who does a pretty damn good job summing up its function, "bindgen uses 
quickcheck to generate random c header files and then tries to parse them".). 

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">bindgen uses quickcheck to generate random c header files and then tries to parse them <a href="https://t.co/HYftqPra7L">https://t.co/HYftqPra7L</a></p>&mdash; Some(@steveklabnik) (@steveklabnik) <a href="https://twitter.com/steveklabnik/status/939238891118350337?ref_src=twsrc%5Etfw">December 8, 2017</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Check [this gist](https://gist.github.com/shnewto/1b0ca76207139681d98b4d709b8c09ed) 
for a peek into what a couple randomly generated C headers look like.

While unable to meet the goal of uncovering 
["many hidden issues via fuzzing"](https://paper.dropbox.com/doc/bindgen-xTXplHlfqJpnDvPhMqmfW), the 
[quickchecking crate](https://github.com/rust-lang-nursery/rust-bindgen/tree/master/tests/quickchecking) 
caught [one new bug](https://github.com/rust-lang-nursery/rust-bindgen/issues/1153)
and is able to regularly catch a couple others, 
[#550](https://github.com/rust-lang-nursery/rust-bindgen/issues/550)
and [#684](https://github.com/rust-lang-nursery/rust-bindgen/issues/684). To me
that shortcoming means a couple things. One, there's still room to improve the 
crate by 
[generating a broader range of viable code](https://github.com/rust-lang-nursery/rust-bindgen/issues/1170) 
and by support for 
[whitelisting and opaque types](https://github.com/rust-lang-nursery/rust-bindgen/issues/1171).
Two, [bindgen](https://github.com/rust-lang-nursery/rust-bindgen) is already 
doing a great job at doing a lot of things right.

## The impl period experience

Because I do count the experience a success, it's worth noting a couple things 
that went right that may be out of the ordinary.

* I live in Portland, OR where [the sponsor of the Rust project](https://research.mozilla.org/rust/) Mozilla has a presence.

* There was an impl period Meetup nearby where I was able to pick [@fitzgen](https://github.com/fitzgen)'s brain in person, the impl period's [bindgen](https://github.com/rust-lang-nursery/rust-bindgen) project lead.

It's also worth noting the things that I expect apply more generally.

* The presence of [a Gitter channel](https://gitter.im/rust-impl-period/WG-dev-tools-bindgen) influenced the decision to contribute. While I didn't actually use it much, it allowed me to wave, say hi and get a wave back. It was some human interaction that helped reinforce that my work would be seen and that if I did need something, it would be there.

* I loved the newsletters.

* My engagement with the Rust community was enormously positive. 

* The impl period documentation was really, really great. The volume of it all was a bit daunting at first but ended up allowing me to browse until something felt right. I was able to settle on a problem that sounded interesting and represented a chance to learn.

* When I took on the project it was with a clear idea of how to tackle it and that clear idea was __completely__ misguided. Mapping out a new solution and implementing it really scratched the itch.

Participating was a fantastic experience, I hope the impl period is an every year 
thing. It provided a feeling of genuinely leveling up as a Rust developer, 
in some part because it was a new problem to solve but largely because of the 
incredibly thorough and thoughtful feedback from 
[@fitzgen](https://github.com/fitzgen) who reviewed my PRs.

For more info on implementation details I'll probably do a follow up 
post, but in the meantime, if you're interested in knowing more about it check 
out the conversations in the PRs linked to above or 
reach out on Twitter, I'm [@shnewto](https://twitter.com/shnewto). 

I'd like to offer a really enthusiastic thank you to the Rust community and 
everyone involved in organizing and running the impl period for 2017. I'm glad 
for the experience and look forward to engaging more. 

Also, a huge thanks to [@craftloopz](https://twitter.com/craftloopz) for
working with me through the drafts of this post. She's an amazing editor and 
helped me shape something I'm glad to share.  
