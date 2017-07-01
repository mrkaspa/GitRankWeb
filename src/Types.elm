module Types exposing (..)

import Http
import Plot exposing (Point)


type alias Lang =
    { id : Int
    , name : String
    , stars : Int
    , year : Int
    , month : Int
    }


type alias Model =
    List Lang


type alias LangGrouped =
    List ( String, List Lang )


type Msg
    = DataLoaded (Result Http.Error (List Lang))
    | HoverRangeFrame (Maybe Point)
    | HoverBars (Maybe Point)
