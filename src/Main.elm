module Main exposing (..)

import Html exposing (Html, div, h1, li, text, ul)
import Http
import Json.Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (decode, required)
import Types exposing (..)
import Views


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = Views.view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : ( Model, Cmd Msg )
init =
    ( [], getData )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DataLoaded (Ok newData) ->
            ( newData, Cmd.none )

        _ ->
            ( model, Cmd.none )


getData : Cmd Msg
getData =
    let
        url =
            "/load_info"
    in
    Http.send DataLoaded (Http.get url langsDecoder)


langsDecoder : Decoder (List Lang)
langsDecoder =
    list langDecoder


langDecoder : Decoder Lang
langDecoder =
    decode Lang
        |> required "langs_id" int
        |> required "langs_name" string
        |> required "stats_stars" int
        |> required "stats_year" int
        |> required "stats_month" int
