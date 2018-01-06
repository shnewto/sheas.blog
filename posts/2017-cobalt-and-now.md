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
The work of starting a blog intimidated me for a long time and I'd like to talk 
a bit about how I made it past being intimidated. Some of what intimidated
me in the past was the idea of finding time. Whether I'm actually able to find
time isn't clear yet but I reached a point where I thought I'd try. The
remaining problem stemmed from indecision. I wanted the solution to be 
_just right_ but couldn't decide what that even meant. A part of me leaned 
toward a nice prefab solution like [svbtle](https://svbtle.com/) or falling back 
to a free WordPress theme. Another part of me though, wanted to use the personal 
blog project as an excuse to learn new tooling and level up in areas that I 
don't have much experience.

Some experiecnce with [Hugo](https://gohugo.io/) in the past had been positive, 
it made a lot of the work seem approachable. When it comes to open source 
solutions for hobby or "side" projects though, I've started to lean toward 
projects that are a little younger or have at least have a little less 
spotlight. I'm more often able to find some unpolished corner that gives me an 
excuse to contribute to it and hopefully, make something cool even better. 

Because I've been on a kind of personal mission to map out some of the 
Rust ecosystem I thought I'd explore what it had to offer. A quick 
browser search for "static site generator rust" turns up a handful of options, 
but out of those, two seemed especially
suited to the task.
[Gutenberg](https://github.com/Keats/gutenberg) and
[cobalt.rs](https://github.com/cobalt-org/cobalt.rs).

### Decisions
The docs for both seemed approachable so I felt optimistic that either choice
would be manageable with effort. Because my experience is especially slim in
design, my choice ultimately came down to finding an existing site built with
either of the tools that had a relatable aesthetic to pull from.

[Matthias Endler's blog](https://matthias-endler.de/) sold me, it's beautiful.
Walking through [that code base](https://github.com/mre/mre.github.io) was a
fantastic tutorial on using cobalt.rs. _This_ site, especially
my CSS, leans pretty heavily on what I found there.

### Lessons
Initially, I didn't appreciate the `.md` and `.liquid` interchangeability. The
first pass only used Markdown but hit a wall when wanted to incorporate 
styling in some draft posts. _That's_ where the `.liquid` extension comes in.
It lets you incorporate raw HTML, and all the power that comes with it, 
into any page (which in my mind is basically magical CSS and JavaScript ha). 
I love not being constrained to Markdown but having it in the toolbox.

### It's built, now what?
Okay, I dug in, hacked some CSS, learned what was and wasn't possible with
Markdown, fought the urge to duplicate the `.liquid` files in the `_layouts`
directory without gaining anything from it and finally had something I thought
I could run with.
But now what? I've been getting paid to write software
for a few years now and I've never had to learn or cemented how to go from local
files to a live website 🙃. Where does all that happen? Do I need a _hosting_
account? Which one? The words _Digital Ocean droplet_ probably mean
something... I spiraled like this for a bit until happily, the memory surfaced 
of video I'd been recommended by a friend ages
ago on [now & next](https://www.youtube.com/watch?v=__b6k2pR3Tg&t=5s),
Node.js packages that I didn't really have an application for
at the time. I revisited the video and gave it a try. Damn, `now` is a 
superpower.

Here are the steps I took to get my blog up and running during development:
1. Install [now](https://zeit.co/download#now-cli).
1. Build the side with `cobalt build`
1. `now deploy _site`? Bam! Live website with a generated URL.

Totally, totally, sold. I ended up springing for the step above a free account 
to associate custom domains with my deploys and support something that blew 
my mind.

To associate your domain with the URL generated with `now deploy`:
1. `now alias <source (generated) URL> <destination URL>`

### Final thoughts
Getting a blog up and running took some leveling up (happily!) but because of
some great tools and the work of others to learn from, it didn't take a ton of
time. It was the work of a weekend and a lot of that was experimentation.
My experiences with both `cobalt.rs` and `now` were hugely positive and
I recommend both for anyone interested in starting something from scratch or
just exploring some new tooling.
