module Dropdown exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias DropdownConfig =
    { label : String
    , elements : List DropdownElement
    }


type alias DropdownElement =
    { text : String
    , href : String
    }


type alias State =
    { expanded : Bool
    , selected : String
    }


init : State
init =
    { expanded = False
    , selected = "Click to Select"
    }


type Msg
    = Toggle
    | Select String


update : Msg -> State -> State
update msg model =
    case msg of
        Toggle ->
            { model | expanded = not model.expanded }

        Select value ->
            { model
                | expanded = False
                , selected = value
            }


dropdownElement : DropdownElement -> Html Msg
dropdownElement element =
    li []
        [ a
            [ class "dropdown-element", href element.href, onClick (Select element.text) ]
            [ text element.text ]
        ]


dropdownAttributes : Bool -> List (Html.Attribute Msg)
dropdownAttributes expanded =
    if expanded then
        [ class "dropdown-menu dropdown-select show-menu" ]
    else
        [ class "dropdown-menu dropdown-select" ]


view : State -> DropdownConfig -> Html Msg
view state config =
    div [ class "dropdown" ]
        [ div [ class "dropdown-container" ]
            [ p [ class "dropdown-description" ]
                [ text config.label ]
            , a [ class "dropdown-button", onClick Toggle ]
                [ text state.selected ]
            , ul (dropdownAttributes state.expanded)
                (List.map dropdownElement config.elements)
            ]
        ]
