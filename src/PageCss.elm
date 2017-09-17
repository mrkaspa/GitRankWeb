module PageCss exposing (css, blueFontColor, colorWheel)

import Css exposing (..)
import Css.Elements exposing (body, h1, h2, div, ul, li, p, svg, img, a)


blueFontColor : String
blueFontColor =
    "#2e3192"


colorWheel : List ( String, String )
colorWheel =
    [ ( "#ffdef6", "#ff00ff" )
    , ( "#dbefec", "#00a7a1" )
    , ( "#feeedf", "#ff9400" )
    , ( "#e1f0e4", "#00b63e" )
    , ( "#e0eff4", "#00ade5" )
    , ( "#fae3e2", "#e12229" )
    ]


css : Stylesheet
css =
    stylesheet
        [ body
            []
        , p
            [ margin (px 0)
            ]
        , a
            [ color (hex blueFontColor)
            , textDecoration none
            ]
        , id "page"
            [ margin auto
            , maxWidth (px 1280)
            , fontFamilies [ "Hind", "sans-serif" ]
            ]
        , id "header"
            [ backgroundColor (hex "f3e9e9")
            , fontWeight bold
            , fontSize (em 2.0)
            , position relative
            , children
                [ h1
                    [ margin (px 0)
                    , padding (px 50)
                    , color (hex blueFontColor)
                    ]
                , div
                    [ position absolute
                    , top (px 0)
                    , right (px 3)
                    , children
                        [ a
                            [ margin (px 5)
                            ]
                        ]
                    ]
                ]
            ]
        , id "content"
            [ backgroundColor (hex "ffe9f2")
            , children
                [ img
                    [ height (px 300)
                    , width (px 300)
                    , display block
                    , margin2 (px 20) auto
                    ]
                , p
                    [ textAlign center
                    , color (hex blueFontColor)
                    , fontSize (em 1.5)
                    ]
                ]
            ]
        , id "top"
            [ displayFlex
            , flexWrap wrap
            , padding2 (px 20) (px 0)
            , children
                [ ul
                    [ flex3 (num 0) (num 0) (pct 41.5)
                    , padding4 (px 0) (px 0) (px 0) (px 40)
                    , margin (px 0)
                    , listStyle none
                    , children
                        [ li
                            [ displayFlex
                            , flexWrap wrap
                            , fontSize (em 1.5)
                            , padding2 (px 10) (px 5)
                            , color (hex blueFontColor)
                            , textTransform capitalize
                            , children
                                [ div
                                    [ nthOfType "1"
                                        [ flex3 (num 0) (num 0) (pct 40)
                                        , children
                                            [ svg
                                                [ display block
                                                , margin auto
                                                ]
                                            ]
                                        ]
                                    , nthOfType "2"
                                        [ flex3 (num 0) (num 0) (pct 55)
                                        , children
                                            [ p
                                                [ textAlign center
                                                , nthOfType
                                                    "2"
                                                    [ fontSize (em 0.8)
                                                    ]
                                                ]
                                            ]
                                        ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                , div
                    [ flex3 (num 0) (num 0) (pct 55)
                    ]
                ]
            ]
        , id "stats"
            [ backgroundColor (hex "faf7f5")
            , padding2 (px 55) (px 0)
            , displayFlex
            , flexWrap wrap
            , children
                [ class "chart"
                    [ flex3 (num 0) (num 0) (pct 50)
                    , children
                        [ h2
                            [ textTransform capitalize
                            , textAlign center
                            ]
                        ]
                    ]
                ]
            ]
        , id "footer"
            [ color (hex blueFontColor)
            , textAlign center
            , padding2 (px 10) (px 0)
            , children
                [ p
                    [ nthOfType "1"
                        [ fontSize (em 1.8)
                        ]
                    ]
                ]
            ]
        ]
