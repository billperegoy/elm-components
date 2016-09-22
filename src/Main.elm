module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Accordion exposing (..)


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { accordion1 : Accordion.Model
    , accordion2 : Accordion.Model
    }


type Msg
    = NoOp
    | Accordion1 Accordion.Msg
    | Accordion2 Accordion.Msg


initAccordionData1 : AccordionData Accordion.Msg
initAccordionData1 =
    { elements = initAccordionElements
    }


initAccordionData2 : AccordionData Accordion.Msg
initAccordionData2 =
    { elements = initAccordionElements
    }


initAccordionElements : List (AccordionElement Accordion.Msg)
initAccordionElements =
    [ AccordionElement "Accordion Item 1"
        [ accordionSubItem [ text "Sub Item 1" ]
        , accordionSubItem [ text "Sub Item 2" ]
        , accordionSubItem [ text "Sub Item 3" ]
        ]
    , AccordionElement "Accordion Item 2"
        [ accordionSubItem [ text "Sub Item 4" ]
        , accordionSubItem [ text "Sub Item 5" ]
        , accordionSubItem [ text "Sub Item 6" ]
        ]
    , AccordionElement "Accordion Item 3"
        [ accordionSubItem [ text "Sub Item 7" ]
        , accordionSubItem [ text "Sub Item 8" ]
        , accordionSubItem [ text "Sub Item 9" ]
        , accordionSubItem [ text "Sub Item 10" ]
        , accordionSubItem [ text "Sub Item 11" ]
        , accordionSubItem [ text "Sub Item 12" ]
        ]
    , AccordionElement "Accordion Item 4"
        [ accordionSubItem [ text "Sub Item 13" ]
        , accordionSubItem [ text "Sub Item 14" ]
        , accordionSubItem [ text "Sub Item 15" ]
        ]
    ]


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Accordion1 msg ->
            let
                ( result, cmd ) =
                    Accordion.update msg model.accordion1
            in
                { model | accordion1 = result } ! [ cmd ]

        Accordion2 msg ->
            let
                ( result, cmd ) =
                    Accordion.update msg model.accordion2
            in
                { model | accordion2 = result } ! [ cmd ]


init1 : Accordion.Model
init1 =
    { name = "accordion-1"
    , visible =
        [ ( 0, False )
        , ( 1, False )
        , ( 2, False )
        , ( 3, False )
        ]
    , toggleSpeed = Fast
    }


init2 : Accordion.Model
init2 =
    { name = "accordion-2"
    , visible =
        [ ( 0, False )
        , ( 1, False )
        , ( 2, False )
        , ( 3, False )
        ]
    , toggleSpeed = Custom 3000
    }


init : ( Model, Cmd Msg )
init =
    { accordion1 = init1
    , accordion2 = init2
    }
        ! []


view : Model -> Html Msg
view model =
    div [ style [ ( "width", "200px" ) ] ]
        [ App.map Accordion1 (Accordion.view model.accordion1 initAccordionData1)
        , App.map Accordion2 (Accordion.view model.accordion2 initAccordionData2)
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
