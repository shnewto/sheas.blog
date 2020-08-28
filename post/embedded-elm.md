# Embedded Elm
✨


Bob is a lackadaisical teenager. In conversation, his responses are very limited.

* Bob answers 'Sure.' if you ask him a question.
* He answers 'Whoa, chill out!' if you yell at him.
* He says 'Fine. Be that way!' if you address him without actually saying anything.
* He answers 'Whatever.' to anything else.

<div id="elm"></div>

<head>
    <script src="/res/elm/embedded-elm.js"></script>
	<script>
		var node = document.getElementById('elm');
		var app = Elm.Bob.embed(node);
	</script>
</head>

<br>
<hr>
<br>

I've been interested in dipping my toes into the Elm language for some time
and curious about whether it was possible / reasonable to integrate
something written in Elm into the Cobalt tooling used to generate this blog.
_Bob_ is the evidence that it's possible. He's an implementation of the
[Bob in Elm](http://exercism.io/exercises/elm/bob/readme) exercise from 
[exercism.io](http://exercism.io)
(source available [here](https://github.com/shnewto/sheas.blog/blob/master/static/2017/Bob/Bob.elm), 
don't look if you don't want it spoiled!).

Major points to Cobalt because integration was pretty trivial. After generating 
the JavaScript (`elm-make Bob.elm --output=some-filename.js`), it can be
embedded in the raw HTML of a post's `.liquid` file like any other 
`.js` file. Or almost. The HTML + Elm was accomplished 
as follows:

```html
<div id="elm"></div>
<head>
    <script src="/assets/2017/embedded-elm.js"></script>
    <script>
        var node = document.getElementById('elm');
        var app = Elm.Bob.embed(node);
    </script>
</head>
```

Learning enough Elm to make something happen was the difficulty. I love
language learning tooling like <a href="http://exercism.io">exercism.io</a> so 
started there. Dusting off the functional programming brain was much less 
painful using their examples and I'm a total sucker for getting tests to pass.
<br><br>
Next was asking for help, something I'm trying to get better at. While the 
compiler and documentation are really helpful, it's sometimes worth admitting 
that learning from someone who's been through it already is invaluable. The
<a href="https://www.freecodecamp.org/">freeCodeCamp</a> mantra
<a href="https://medium.freecodecamp.org/read-search-dont-be-afraid-to-ask-743a23c411b4">Read, Search, (Don’t Be Afraid to) Ask</a>
has influeced me in that.
<a href="https://twitter.com/CrockAgile">@CrockAgile</a>,
a friend who had been through some of the learning process provided some really 
great guidance in sorting out the implementation details I'd been unable to 
glean from the first couple <a href="http://exercism.io">exercism.io</a>
exercises. Things like the following code block that I can't say I fully grok 
so am likely to revisit for any future Elm application I write.

```elm
type Msg
    = NewInput String
    | Said


type alias Model =
    ( String, String )


main : Program Never Model Msg
main =
    Html.program
        { init = ( ( "", "" ), Cmd.none )
        , view = view
        , update = update
        , subscriptions = (\x -> Sub.none)
        }
```

So check out the source and experiment with <i>Bob</i> if you're interested in Elm 
too. If you're someone with experience and have suggestions on
implementation, or you're a beginner like me with questions, feel to reach out.
I'm <a href="https://twitter.com/shnewto">@shnewto</a> on Twitter.
