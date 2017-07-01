module ListHelper exposing (cycle, zipWithCycle)

import List.Extra as ListExtra


cycle : Int -> List a -> List a
cycle len xs =
    if List.length xs > len then
        xs
    else
        cycle len (xs ++ xs)


zipWithCycle : List a -> List b -> List ( a, b )
zipWithCycle xs ys =
    ys
        |> cycle (List.length xs)
        |> ListExtra.zip xs
