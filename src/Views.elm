module Views exposing (view)

import Html exposing (Html, h1, h2, text, div, ul, li, p, img, br, a, i)
import Html.Attributes exposing (id, style, class, src, href, attribute)
import Chart exposing (graph, drawCircle)
import Types exposing (Model, Lang, LangGrouped, Msg)
import PageCss exposing (colorWheel)
import Dict.Extra as DictExtra
import Dict exposing (Dict)
import ListHelper


view : Model -> Html Msg
view model =
    let
        langs =
            mapModelToLangGrouped model

        top =
            List.take 5 langs
    in
        div [ id "page" ]
            [ viewHeader
            , viewTop top
            , div [ id "stats" ]
                (viewCharts langs)
            , viewFooter
            ]


viewHeader : Html Msg
viewHeader =
    div [ id "header" ]
        [ h1 []
            [ text "GitRank" ]
        , div []
            [ a [ href "https://www.behance.net/juanvega90d39a" ]
                [ i [ class "fa fa-behance-square", attribute "aria-hidden" "true" ] []
                ]
            , a [ href "https://www.github.com/mrkaspa" ]
                [ i [ class "fa fa-github-square", attribute "aria-hidden" "true" ] []
                ]
            ]
        ]


viewTop : LangGrouped -> Html Msg
viewTop top =
    let
        topWithColors =
            top
                |> mixWithColors
                |> List.map makeListItem
    in
        div [ id "top" ]
            [ div [ id "content" ]
                [ img [ src "/static/git.png" ] []
                , p [] [ text "The perfect place to check the growing of your favorites programming languages " ]
                ]
            , ul [] topWithColors
            ]


viewCharts : LangGrouped -> List (Html Msg)
viewCharts langs =
    langs
        |> mixWithColors
        |> List.map langChart


viewFooter : Html Msg
viewFooter =
    div [ id "footer" ]
        [ p []
            [ text "GitRank"
            ]
        , p []
            [ text "Designed by "
            , a [ href "https://www.behance.net/juanvega90d39a" ] [ text "Juan Vega" ]
            , text " - Developed by "
            , a [ href "https://www.github.com/mrkaspa" ] [ text "Michel Perez" ]
            , br [] []
            , text "© Copyright 2017 by Juan Vega"
            ]
        ]


langChart : ( ( String, List Lang ), ( String, String ) ) -> Html Msg
langChart ( ( name, data ), ( lColor, sColor ) ) =
    let
        chart =
            data
                |> parseAsPairs
                |> graph sColor
    in
        div [ class "chart", style [ ( "background-color", lColor ) ] ]
            [ h2 [ style [ ( "color", sColor ) ] ] [ text name ]
            , chart
            ]


makeListItem : ( ( String, List Lang ), ( String, String ) ) -> Html Msg
makeListItem ( ( name, data ), ( lColor, sColor ) ) =
    let
        stars =
            getFirstStars data
    in
        li [ style [ ( "backgroundColor", lColor ) ] ]
            [ div []
                [ drawCircle sColor
                ]
            , div []
                [ p []
                    [ text name
                    ]
                , p []
                    [ text (toString stars)
                    ]
                ]
            ]


parseAsPairs : List Lang -> List ( Float, Float )
parseAsPairs dataLang =
    dataLang
        |> List.map (\{ stars, year, month } -> ( toFloat ((year * 100) + month), toFloat stars ))
        |> List.sortBy (\( date, _ ) -> date)
        |> List.reverse


mapModelToLangGrouped : Model -> LangGrouped
mapModelToLangGrouped model =
    model
        |> DictExtra.groupBy .name
        |> Dict.toList
        |> List.sortBy (\( _, stats ) -> getFirstStars stats)
        |> List.reverse


getFirstStars : List Lang -> Int
getFirstStars stats =
    stats
        |> List.head
        |> Maybe.map .stars
        |> Maybe.withDefault 0


mixWithColors : LangGrouped -> List ( ( String, List Lang ), ( String, String ) )
mixWithColors langs =
    ListHelper.zipWithCycle langs colorWheel
