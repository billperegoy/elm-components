module ButtonGroup exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias ButtonConfig =
    List ButtonElement


type alias ButtonElement =
    { value : String
    , text : String
    }


buttonElement : ButtonElement -> Html msg
buttonElement button =
    label []
        [ input [ name "button-group", type' "radio", value button.value ]
            []
        , span [ class "button-group-item" ]
            [ text button.text ]
        ]


view : ButtonConfig -> Html msg
view config =
    div [ class "button-group" ]
        (List.map buttonElement config)
