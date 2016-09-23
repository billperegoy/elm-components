port module Accordion exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)


--
-- Model
--


type ToggleSpeed
    = Fast
    | Slow
    | Custom Int


type alias AccordionData a =
    { elements : List (AccordionElement a)
    , name : String
    , toggleSpeed : ToggleSpeed
    }


type alias AccordionElement a =
    { label : String
    , items : List (Html a)
    }


type alias VisibilityElement =
    ( Int, Bool )


type alias Model =
    { visible : List VisibilityElement
    }



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


update : Msg -> Model -> ( Model, Cmd a )
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
        ( visibility, data ) =
            visibiityTuple
    in
        li []
            [ a
                [ id (itemIdString (fst visibility))
                , class (expandedClass visibility)
                , href "javascript:void(0)"
                , onClick (Toggle name (fst visibility) toggleSpeed)
                ]
                [ text data.label ]
            , ul
                [ class "submenu" ]
                data.items
            ]


accordionList : Model -> AccordionData Msg -> Html Msg
accordionList model data =
    let
        zippedData : List ( VisibilityElement, AccordionElement Msg )
        zippedData =
            List.map2 (,) model.visible data.elements
    in
        ul [ class "accordion", id data.name ]
            (List.map (accordionItem data.name data.toggleSpeed) zippedData)


view : Model -> AccordionData Msg -> Html Msg
view model data =
    div []
        [ accordionList model data
        ]


port toggleAccordion : ( String, String, Int ) -> Cmd msg
