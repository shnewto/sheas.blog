extends: default.liquid

title: cobalt.rs and now
draft: false
date: 26 Nov 2017 15:05:00 +0000
calendardate: November 26, 2017
path: 2017/cobalt-and-now

---

Detailing the work of getting this blog put together using
_[cobalt.rs](https://github.com/cobalt-org/cobalt.rs)_ and deploying
with _[now](https://zeit.co/now)_.

### Time for a project
I've been thinking about (and putting off) getting a personal blog together for
awhile but was honestly intimidated by what work might be involved. The
problem stemmed from indecision.
A part of me leaned toward a nice prefab solution like
[svbtle](https://svbtle.com/) or falling back to WordPress,
something I'd toyed with in the past. But another part of me wanted to use a
personal blog project as an excuse to learn some new tooling and level up in
areas that I don't have much experience. That part of me won out.

I've had some positive experiences with [Hugo](https://gohugo.io/) which made a
lot of the work seem
approachable but I wanted to explore alternative options, namely what Rust had
to offer in the arena. A quick browser search for "static site generator rust"
turns up a handful of options, but out of those, two seemed especially
suited to what I was interested in.
[Gutenberg](https://github.com/Keats/gutenberg) and
[cobalt.rs](https://github.com/cobalt-org/cobalt.rs).

### Decisions
The docs for both seemed approachable so I felt optimistic that either choice
would be manageable with effort. Because my experience is especially slim in
design, my choice ultimately came down to finding an existing site built with
either of the tools that had an aesthetic I liked and could pull from.

[Matthias Endler's blog](https://matthias-endler.de/) sold me, it's beautiful.
Walking through [that code base](https://github.com/mre/mre.github.io) was a
fantastic tutorial on using cobalt.rs and _this_ site, especially
my CSS, leans pretty heavily on what I learned there.

### Lessons
Initially I didn't appreciate the `.md` and `.liquid` interchangeability. My
first pass only used Markdown but then I wanted to incorporate styling... That's
where the `.liquid` extension comes in! It lets you incorporate raw HTML,
and all the power that comes with it, into any page (which in my mind is magical
CSS and JavaScript ha). I love that I'm not constrained to Markdown but have it
in the toolbox.

### It's built, now what?
Okay, I dug in, hacked some CSS, learned what I could and couldn't do with
Markdown, fought the urge to duplicate the `.liquid` files in the `_layouts`
directory without gaining anything from it and finally had something I thought
I could run with.
But now what? I've been getting paid to write software
for a few years now and I've never had to learn or cemented how to go from local
files to a live website. 🙃. Where does all that happen? Do I need a _hosting_
account?
Which one? I've heard the words _Digital Ocean droplet_, that's probably
something... Then I remembered a video I'd been recommended by a friend ages
ago on [now & next](https://www.youtube.com/watch?v=__b6k2pR3Tg&t=5s),
Node.js packages that I didn't really have an application for
at the time. I thought I'd try it out. And damn, `now` is a super power.

Here were the steps I took to get my blog up and running during development:
1. Is `now` still installed? Yep.
1. What does `now -h` give me? Ah `deploy` seems promising.
1. `now deploy _site`? Bam! Live website with a generated URL.

Totally, totally, sold, I ended up springing for the step above free account
so I could associate my custom domains with the deploys and also support
something that blew my mind.

### Final thoughts
Getting a blog up and running took some leveling up (happily!) but because of
some great tools and the work of others to learn from, it didn't take a ton of
time. It was the work of a weekend and a lot of that was experimentation.
My experiences with both `cobalt.rs` and `now` were hugely positive and
I recommend both for anyone interested in starting something from scratch or
just exploring some new tooling.
