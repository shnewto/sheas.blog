module BlogPost exposing (blogPost)

import Html exposing (h1, div, text, input, button)
import Html.Events exposing (onInput, onClick)
import Regex


type Msg
    = NewInput String
    | Asked


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

view : Model -> Html.Html Msg
view ( pre, pending ) =
    div []
        [ div []
            [ input [ onInput NewInput ] []
            , button [ onClick Asked ] [ text "Ask!" ]
            ]
        , text (hey pending)
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( pre, pending ) =
    case msg of
        NewInput str ->
            ( ( str, pending ), Cmd.none )

        Asked ->
            ( ( pre, pre ), Cmd.none )


blogPost : String
blogPost =
    "Hello, World!"


hey : String -> String
hey words =
    case String.length (String.trim words) == 0 of
        True ->
            "Fine. Be that way!"

        False ->
            case
                Regex.contains (Regex.regex "[A-z]+") words
                    && String.toUpper words
                    == words
            of
                True ->
                    "Whoa, chill out!"

                False ->
                    case String.endsWith "?" words of
                        True ->
                            "Sure."

                        False ->
                            "Whatever."
