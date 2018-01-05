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
life better for Rust developers that need to use C or C++ by automatically 
genertating bindings to existing libraries. It's something I'd used in the 
past for exactly that, writing Rust code that interfaces with existing C. 
It did everything it promised and I'm incredibly glad it's in the ecosystem.

Though I didn't directly touch any of _bindgen's_ functionality, the work I 
did will hopefully help contribute to its growth. I took on the call to 
[add property based testing with quickcheck](https://github.com/rust-lang-nursery/rust-bindgen/issues/970).
For anyone unfamiliar, some of the power of property testing might be boiled 
down to it's efficiency in testing an exahustive set of inputs. One property test 
has the potential to excercise what in other paradigms, often requires an 
impractical or even impossible number of individual tests. 
[quickcheck](https://github.com/BurntSushi/quickcheck) is a Rust package that 
enables writing property tests 
(in the vein of [the original QuickCheck written in Haskell](https://en.wikipedia.org/wiki/QuickCheck)) 
for Rust projects.

My contributions were the following PRs:

* [Property testing with quickcheck](https://github.com/rust-lang-nursery/rust-bindgen/pull/1159)
* [Quickchecking crate CLI](https://github.com/rust-lang-nursery/rust-bindgen/pull/1177)
* [Enable Cargo features for quickchecking crate](https://github.com/rust-lang-nursery/rust-bindgen/pull/1180)

I count my experience as a success. Not because I was able to see three PRs 
merged and the corresponding issues closed but becasue I was noticed by 
[@steveklabnik](https://twitter.com/steveklabnik) (haha who does a pretty damn good
job summing up the work I did with, "bindgen uses quickcheck to generate random 
c header files and then tries to parse them".). 

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">bindgen uses quickcheck to generate random c header files and then tries to parse them <a href="https://t.co/HYftqPra7L">https://t.co/HYftqPra7L</a></p>&mdash; Some(@steveklabnik) (@steveklabnik) <a href="https://twitter.com/steveklabnik/status/939238891118350337?ref_src=twsrc%5Etfw">December 8, 2017</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Check [this gist](https://gist.github.com/snewt/1b0ca76207139681d98b4d709b8c09ed) 
for a peek into what a couple randomly generated C headers look like.

While I wasn't able to meet the goal of uncovering 
["many hidden issues via fuzzing"](https://paper.dropbox.com/doc/bindgen-xTXplHlfqJpnDvPhMqmfW), the 
[quickchecking crate](https://github.com/rust-lang-nursery/rust-bindgen/tree/master/tests/quickchecking) 
has caught [one new bug](https://github.com/rust-lang-nursery/rust-bindgen/issues/1153), 
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

* I was able to go to an impl period Meetup and pick [@fitzgen](https://github.com/fitzgen)'s brain in person, the impl period's [bindgen](https://github.com/rust-lang-nursery/rust-bindgen) project lead.

It's also worth noting the things that I expect apply more generally.

* The presence of a Gitter channel influenced my decision to contribute. I didn't actually use it much but it allowed me to wave, say hi and get a wave back. It was some human interaction that helped reinforce that my work would be seen and that if I did need somthing, it would be there.

* I loved the newsletters.

* I went to an impl period Meetup and my engagement with the Rust community was enormously positive. 

* The impl period documentation was really, really great. The volume of it all was a bit daunting at first but I ended up appreciating that I was able to browse until something felt right. I was able to settle on a problem that sounded interesing to me and represented a chance to learn.

* When I took on the project I had a clear idea of how to tackle it and that clear idea was __completely__ misguided. Mapping out a new solution and implementing it really scratched the itch.


I had a fantastic time participating and I hope the impl period is an every year 
thing. I also feel like I genuinely leveled up as a Rust developer, in some part 
because I had a new problem to solve but largely because of the incredibly 
thourough and thoughtful feedback I got from 
[@fitzgen](https://github.com/fitzgen) who reviewed my PRs.

For more info on implementation details I'll probably do a follow up 
post, but in the meantime, if you're interested in knowing more about it I'll 
recommend checking out the conversations in the PRs linked to above or 
reaching out on Twitter, I'm [@shnewto](https://twitter.com/shnewto). 

I'd like to offer a really enthusiastic thank you to the Rust community and 
everyone involved in organizing and running the impl period for 2017. I'm glad 
for the experience and look forward to engaging more.