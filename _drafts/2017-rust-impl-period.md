extends: default.liquid

title: The Rust impl period and me
draft: true
date: 21 Dec 2017 11:13:00 +0000
calendardate: December 21, 2017
path: 2017/rust-impl-period

---

The [Rust programming language](https://www.rust-lang.org) is a self-declared
"systems programming language that runs blazingly fast, prevents segfaults, and
guarantees thread safety." It's 
[impl period](https://internals.rust-lang.org/t/the-final-impl-period-newsletter/6408)
is a sort of seasonal community Rust project, or organization of projects.
To paraphrase [Aaron Turon](https://internals.rust-lang.org/t/announcing-the-impl-period-sep-18-dec-17/5676),
it is a time for the Rust community to come together to focus on implemenation 
work rather than design/RFC work. 

I've been lucky enough to have had the opportunity learn Rust in order to write
it at work over the last year or so. [PolySync](https://polysync.io/) is
[a friend of Rust](https://www.rust-lang.org/en-US/friends.html) and we've been
moving from _using_ Rust to _favoring_ it. My experience with the language at
work drove me to explore the ecosystem on my own and to eventually to write
Rust for myself, outside of work. I recently published a crate I'm reasonably 
proud of called [bnf](https://crates.io/crates/bnf), a library for parsing 
Backus–Naur form context-free grammars. I also recently participated in
 _the impl period_, something I'm reasonably proud of as well.

## A quickchecking crate

My part in Rust's _the impl period_ project was work for
[bindgen](https://github.com/rust-lang-nursery/rust-bindgen), a tool that makes
life better for C and C++ developers by automatically genertating bindings to
existing libraries. It's something I'd used in the past for exactly that, writng
Rust code that interfaces with existing C. It did everything it promised and 
I'm incredibly glad to it's in the ecosystem.

Though I didn't directly touch any of _bindgen's_ functionality, the work I 
did will hopefully contribute to its growth. I took on the call to 
[add property based testing with quickcheck](https://github.com/rust-lang-nursery/rust-bindgen/issues/970).
For anyone unfamiliar, some of the power of property testing might be boiled 
down to it's effciency in testing an exahustive set of inputs. One property test 
has the potential to excercise what in other paradigms, often requires an 
impractical or even impossible number of individual tests. 
_[quickcheck](https://github.com/BurntSushi/quickcheck)_ is a Rust package that 
enables writing property tests 
(in the vein of [the original QuickCheck written in Haskell](https://en.wikipedia.org/wiki/QuickCheck)) 
for Rust projects.

My contributions were the following PRs:

* [Property testing with quickcheck](https://github.com/rust-lang-nursery/rust-bindgen/pull/1159)
* [Quickchecking crate CLI](https://github.com/rust-lang-nursery/rust-bindgen/pull/1177)
* [Enable Cargo features for quickchecking crate](https://github.com/rust-lang-nursery/rust-bindgen/pull/1180)

I count my experience as a success. Not because I was able to see three PRs 
merged and the corresponding issues closed but becasue I was noticed by 
[@steveklabnik](https://twitter.com/steveklabnik) who does a pretty damn good
job summing up the work I did. I will say though, tests are extra fun when 
they are able to catch something and while the end product, as far as I know, 
has caught [one new bug](https://github.com/rust-lang-nursery/rust-bindgen/issues/1153), 
it regularly catches a couple others, [#550](https://github.com/rust-lang-nursery/rust-bindgen/issues/550)
and [#684](https://github.com/rust-lang-nursery/rust-bindgen/issues/684).

For more information on implementation details I'll probably do a follow up post but in the meantime, if you're interested the 
conversations on any of the PRs does a good job summing things up too. 


<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">bindgen uses quickcheck to generate random c header files and then tries to parse them <a href="https://t.co/HYftqPra7L">https://t.co/HYftqPra7L</a></p>&mdash; Some(@steveklabnik) (@steveklabnik) <a href="https://twitter.com/steveklabnik/status/939238891118350337?ref_src=twsrc%5Etfw">December 8, 2017</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


Here's some context for things that went right that may be out of the ordinary.

* I live in Portland, OR where there is a Mozilla presence.

* I was able to go to an impl period Meetup and pick [@fitzgen](https://github.com/fitzgen)'s brain in person.

* I'd very recently been working on a personal Rust projet, the [bnf](https://github.com/snewt/bnf) crate that informed a lot of the work I was able to do for [bindgen](https://github.com/rust-lang-nursery/rust-bindgen).

Then there are some things that I expect are more generalizable.

* The presence of a Gitter channel influenced my decision to contribute. I didn't actually use it much but it allowed me to wave, say hi and get a wave back. It was some human interaction that helped reinforce that my work would be seen and that if I did need somthing, it would be there.

* I went to an impl period Meetup and my engagement with the Rust community was enormously positive. Beyond the opportunity to pick the brain of a [bindgen](https://github.com/rust-lang-nursery/rust-bindgen) maintainer, I could pick other people's brains and felt welcome as someone relatively new to the Rust community.

* I settled on a problem that sounded interesing to me and represented a chance to learn.

* When I was finally in a position that I felt warranted feedback and made a PR, I received incredibly thourough and thoughtful feedback. It empowered me to continue and to meaningfully improve my contribution.

* The impl period documentation was really, really great. The volume of it all was a bit daunting at first but I ended up appreciating that I was able to browse until something felt right.

* When I took on the project I had a clear idea of how to tackle it and that clear idea was completely misguided! Mapping out a new solution and implementing it really scratched the itch.

I'll plan on following up with a post detailing some implementation specifics around my work on the [quickchecking crate](https://github.com/rust-lang-nursery/rust-bindgen/tree/master/tests/quickchecking) but for now I'll close by offering a really enthusiastic thank you to the Rust community and everyone involved in organizing and running the impl period for 2017. I'm glad for the experience and look forward to engaging more!
