module Views exposing (viewCharts)

import Html exposing (Html, span, text, br, div)
import Html.Attributes exposing (style)
import Chart exposing (graph)
import Types exposing (Lang, LangGrouped, Msg)
import ListHelper


colorWheel =
    [ ( "#ffdef6", "#ff00ff" )
    , ( "#ceeef6", "#cee0ff" )
    ]


mixWithColors : LangGrouped -> List ( ( String, List Lang ), ( String, String ) )
mixWithColors langs =
    ListHelper.zipWithCycle langs colorWheel


viewCharts : LangGrouped -> List (Html Msg)
viewCharts langs =
    langs
        |> mixWithColors
        |> List.map langChart


langChart : ( ( String, List Lang ), ( String, String ) ) -> Html Msg
langChart ( ( name, data ), ( lColor, sColor ) ) =
    let
        chart =
            data
                |> parseAsPairs
                |> graph sColor
    in
        div []
            [ div [ style [ ( "background-color", lColor ) ] ]
                [ span [ style [ ( "color", sColor ) ] ] [ text name ]
                , chart
                ]
            , br [] []
            , br [] []
            ]


parseAsPairs : List Lang -> List ( Float, Float )
parseAsPairs dataLang =
    dataLang
        |> List.map (\{ stars, year, month } -> ( toFloat ((year * 100) + month), toFloat stars ))
        |> List.sortBy (\( date, _ ) -> date)
        |> List.reverse
