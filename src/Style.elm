port module Style exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import PageCss


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "index.css", Css.File.compile [ PageCss.css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
