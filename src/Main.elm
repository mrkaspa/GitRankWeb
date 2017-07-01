module Main exposing (..)

import Html exposing (Html, div, text, ul, li, h1)
import Http
import Json.Decode exposing (int, string, list, Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import Types exposing (..)
import Views exposing (..)
import Dict.Extra as DictExtra
import Dict exposing (Dict)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


init : ( Model, Cmd Msg )
init =
    ( [], getData )


view : Model -> Html Msg
view model =
    let
        langs =
            mapModelToLangGrouped model

        topGrouped =
            List.take 5 langs
    in
        div []
            ([ h1 [] [ text "Welcome to gitrank" ]
             , ul [] (List.map makeListItem topGrouped)
             ]
                ++ (viewCharts langs)
            )


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


getFirstStars : List Lang -> Int
getFirstStars stats =
    stats
        |> List.head
        |> Maybe.map .stars
        |> Maybe.withDefault 0


makeListItem : ( String, List Lang ) -> Html Msg
makeListItem ( name, stats ) =
    let
        stars =
            getFirstStars stats
    in
        li [] [ text (name ++ " - " ++ (toString stars)) ]


mapModelToLangGrouped : Model -> LangGrouped
mapModelToLangGrouped model =
    model
        |> DictExtra.groupBy .name
        |> Dict.toList
        |> List.sortBy (\( _, stats ) -> getFirstStars stats)
        |> List.reverse
