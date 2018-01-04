extends: default.liquid

title: The impl period and me
draft: true
date: 21 Dec 2017 11:13:00 +0000
calendardate: December 21, 2017
path: 2017/rust-impl-period

---

The [Rust programming language](https://www.rust-lang.org) "is a systems 
programming language that runs blazingly fast, prevents segfaults, and 
guarantees thread safety." The languages applications and its promise drew me
to it personally as someone who's experience with and honest bias had always 
been C. The implications of C I'd said, are power, speed, and effiecency.
It's level of control. Becasue of it's (_severely_) dangerous nature, it also 
came with some unspoken expectation that you've passed the Bukowski test, that 
to develop C professionally, you were able to 
[walk through the fire well](https://www.goodreads.com/book/show/632901.What_Matters_Most_is_How_Well_You_Walk_Through_the_Fire) 🙃.

After enough time though, and after my experiences with Rust, there was like, a record scratch. 
I sort of looked around with a kind of dread, this feeling that I'd just been romanticizing a 
[_difficult crank who minimally, wasn't good for mental health_](https://www.goodreads.com/review/show/39569121?book_show_action=true&from_review_page=1)...
(I've been fortunate enough that the record scratch was heard at my workplace too. 
PolySync is [a friend of Rust](https://www.rust-lang.org/en-US/friends.html)
. We've started using and favoring Rust, something I'm really excited about.)


## The impl period

[The impl period](https://internals.rust-lang.org/t/the-final-impl-period-newsletter/6408) is a sort of seasonal
community Rust project, or organization of projects. To paraphrase [Aaron Turon](https://internals.rust-lang.org/u/aturon), 
it's a time for the Rust community to come together to focus on implemenation work rather than design/RFC work. 
At the risk of spoiling the rest of the post, it was a fantastic experience, it inspired me to contribute more and 
I hope it's an every year thing .

My part in this community Rust project was work for [bindgen](https://github.com/rust-lang-nursery/rust-bindgen), 
a tool that makes life better for C and C++ developers by automatically genertating bindings to existing libraries. 
It's something I'd used in the past for exactly that, writng Rust code that interfaces with existing C and 
I'm incredibly glad to it's in the ecosystem.

Though I didn't directly effect any of _bindgen's_ functionality, the work I did will hopefully contribute to its
growth. I took on the call to [add property based testing with quickcheck](https://github.com/rust-lang-nursery/rust-bindgen/issues/970). 
For anyone unfamiliar, some of the power of property testing might be boiled down to it's effciency in testing an exahustive set inputs.
One test has the potential to test many inputs, something that often requires many individual tests 


My contributions were the following PRs:
* [Property testing with quickcheck](https://github.com/rust-lang-nursery/rust-bindgen/pull/1159)
* [Quickchecking crate CLI](https://github.com/rust-lang-nursery/rust-bindgen/pull/1177)
* [Enable Cargo features for quickchecking crate](https://github.com/rust-lang-nursery/rust-bindgen/pull/1180)

I count my experience as a success, I was able to see three PRs merged and the corresponding issues closed. I'd like to 
talk a bit about what went right.

First off, here's some context for things that may be out of the ordinary.

* I live in Portland, OR where there is a Mozilla presence.

* I was able to go to an impl period Meetup and pick [@fitzgen](https://github.com/fitzgen)'s brain in person.

* I'd very recently been working on a personal Rust projet, the [bnf](https://github.com/snewt/bnf) crate that informed a lot of the work I was able to do for [bindgen](https://github.com/rust-lang-nursery/rust-bindgen).

Then there are some things that I expect are more generalizable.

* The presence of a Gitter channel influenced my decision to contribute. I didn't actually use it much but it allowed me to wave, say hi and get a wave back. It was some human interaction that helped reinforce that my work would be seen and that if I did need somthing, it would be there. 

* I went to an impl period Meetup and my engagement with the Rust community was enormously positive. Beyond the opportunity to pick the brain of a [bindgen](https://github.com/rust-lang-nursery/rust-bindgen) maintainer, I could pick other people's brains and felt welcome as someone relatively new to the Rust community. 

* I settled on a problem that sounded interesing to me and represented a chance to learn.

* When I was finally in a position that I felt warranted feedback and made a PR, I received incredibly thourough and thoughtful feedback. It empowered me to continue  and to meaningfully improve my contribution.

* The impl period documentation was really, really great. The volume of it all was a bit daunting at first but I ended up appreciating that I was able to browse until something felt right. 

* When I took on the project I had a clear idea of how to tackle it and that clear idea was completely misguided! Mapping out a new solution and implementing it really scratched the itch. 


I'll plan on following up with a post detailing some implementation specifics around my work on the [quickchecking crate](https://github.com/rust-lang-nursery/rust-bindgen/tree/master/tests/quickchecking) but for now I'll close by offering a really enthusiastic thank you to the Rust community and everyone involved in organizing and running the impl period for 2017. I'm glad for the experience and look forward to engaging more!


