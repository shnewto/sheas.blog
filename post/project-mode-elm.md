# Project Mode: Elm Edition

_September, 2020_

I’ve been in project mode lately and working on sort of cementing a record of me knowing how to write Elm.

I started out with some high ideals about a web app for journaling / analyzing chess games but when I took just a cursory look at the state of journaling apps out there I felt like I didn’t actually have much to add. 

Instead I sort of built the components I’d figured would be interesting about the a chess journal app, minus the journal.

I started out with a contribution to the Elm package registry, [Pgn](https://package.elm-lang.org/packages/shnewto/pgn/latest/), a library for parsing “portable game notation” for standard chess games. The source for that lives here [https://github.com/shnewto/pgn](https://github.com/shnewto/pgn). 

Next I wanted to work out how to draw a chess board from component pieces, i.e. individual squares images and images for each piece. The motivation was that I wanted something that looked (at least a little bit) like chessboards in books in black and white, and that could be extended to replay games if I decided to implement it sometime down the line. That experiment turned out to be a lot more CSS work that Elm work but I’m still sorta proud about how it turned out :) The board is deployed at [https://chessboard.shnewto.space](https://chessboard.shnewto.space) and the source lives here [https://github.com/shnewto/chessboard](https://github.com/shnewto/chessboard).

Lastly (or at least most recently), I wanted to poke at the chess.com apis and use my Pgn library. So I put together an app that allows you to search for the public games of any chess.com user, browse by month and year, then select a game to display and copy a simplified PGN record of the game you chose. This one’s deployed too, at [https://chesscom-pgn.shnewto.space](https://chesscom-pgn.shnewto.space) and the source lives here [https://github.com/shnewto/chesscom-pgn](https://github.com/shnewto/chesscom-pgn).
