module Chart exposing (graph)

import Plot exposing (..)
import Svg exposing (Svg)
import Svg.Attributes exposing (..)
import Types exposing (Msg)


circle : String -> Float -> Float -> Svg Msg
circle color x y =
    Svg.g
        [ height "100", width "100", viewBox "0 0 100 100" ]
        [ Svg.text_
            [ fill "#2e3192"
            , strokeWidth "1px"
            , textAnchor "middle"
            , Svg.Attributes.x "25"
            , Svg.Attributes.y "10"
            ]
            [ Svg.text (toString y) ]
        , Svg.text_
            [ fill color
            , strokeWidth "1px"
            , textAnchor "middle"
            , Svg.Attributes.x "25"
            , Svg.Attributes.y "25"
            , fontSize "0.7em"
            ]
            [ Svg.text (toString ((round x) // 100) ++ " / " ++ toString ((round x) % 100)) ]
        , Svg.circle
            [ r "8"
            , cx "25"
            , cy "37.5"
            , stroke "transparent"
            , strokeWidth "3px"
            , fill color
            ]
            []
        ]


rangeFrameHintDot : String -> ( Float, Float ) -> DataPoint Msg
rangeFrameHintDot color ( x, y ) =
    { view = Just (circle color x y)
    , xLine = Nothing
    , yLine = Nothing
    , xTick = Nothing
    , yTick = Nothing
    , hint = Nothing
    , x = x
    , y = y
    }


scatter : String -> Series (List ( Float, Float )) Msg
scatter color =
    { axis = sometimesYouDoNotHaveAnAxis
    , interpolation =
        Monotone Nothing
            [ stroke color
            , transform "translate(25,37.5)"
            ]
    , toDataPoints = List.map (rangeFrameHintDot color)
    }


graph : String -> List ( Float, Float ) -> Svg Msg
graph color data =
    viewSeriesCustom
        { defaultSeriesPlotCustomizations
            | horizontalAxis = sometimesYouDoNotHaveAnAxis
            , margin = { top = 20, bottom = 60, left = 10, right = 60 }
            , toRangeLowest = \y -> y - 0.01
            , toDomainLowest = \y -> y - 1
        }
        [ scatter color ]
        data
