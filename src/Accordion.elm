port module Accordion exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)


--
-- State
--


type alias State =
    { visible : List VisibilityElement
    }


type alias VisibilityElement =
    ( Int, Bool )



--
-- Config
--


type alias AccordionConfig a =
    { elements : List (AccordionElement a)
    , name : String
    , toggleSpeed : ToggleSpeed
    }


type alias AccordionElement a =
    { label : String
    , items : List (Html a)
    }


type ToggleSpeed
    = Fast
    | Slow
    | Custom Int



--
-- Update
--


type Msg
    = Toggle String Int ToggleSpeed


toggleIfSelected : Int -> VisibilityElement -> VisibilityElement
toggleIfSelected id tuple =
    if id == fst tuple then
        ( id, not (snd tuple) )
    else
        tuple


speedToInt : ToggleSpeed -> Int
speedToInt speed =
    case speed of
        Fast ->
            200

        Slow ->
            600

        Custom duration ->
            duration


update : Msg -> State -> ( State, Cmd a )
update msg model =
    case msg of
        Toggle name id speed ->
            { model
                | visible = List.map (\e -> toggleIfSelected id e) model.visible
            }
                ! [ toggleAccordion ( name, (itemIdString id), speedToInt speed ) ]



--
-- View
--


accordionSubItem : List (Html a) -> Html a
accordionSubItem content =
    li []
        [ a [ href "javascript:void(0)" ] content
        ]


itemIdString : Int -> String
itemIdString id =
    "item-" ++ toString id


expandedClass : VisibilityElement -> String
expandedClass visibility =
    if snd visibility then
        "is-expanded"
    else
        "is-not-expended"


accordionItem : String -> ToggleSpeed -> ( VisibilityElement, AccordionElement Msg ) -> Html Msg
accordionItem name toggleSpeed visibiityTuple =
    let
        ( visibility, config ) =
            visibiityTuple
    in
        li []
            [ a
                [ id (itemIdString (fst visibility))
                , class (expandedClass visibility)
                , href "javascript:void(0)"
                , onClick (Toggle name (fst visibility) toggleSpeed)
                ]
                [ text config.label ]
            , ul
                [ class "submenu" ]
                config.items
            ]


accordionList : State -> AccordionConfig Msg -> Html Msg
accordionList model config =
    let
        zippedData : List ( VisibilityElement, AccordionElement Msg )
        zippedData =
            List.map2 (,) model.visible config.elements
    in
        ul [ class "accordion", id config.name ]
            (List.map (accordionItem config.name config.toggleSpeed) zippedData)


view : State -> AccordionConfig Msg -> Html Msg
view model config =
    div []
        [ accordionList model config
        ]


port toggleAccordion : ( String, String, Int ) -> Cmd msg
