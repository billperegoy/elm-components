module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Accordion exposing (..)
import Breadcrumb exposing (..)


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { accordion1 : Accordion.State
    , accordion2 : Accordion.State
    }


type Msg
    = Accordion1 Accordion.Msg
    | Accordion2 Accordion.Msg


initAccordionData1 : AccordionConfig Accordion.Msg
initAccordionData1 =
    { elements = initAccordionElements
    , name = "accordion-1"
    , toggleSpeed = Fast
    }


initAccordionData2 : AccordionConfig Accordion.Msg
initAccordionData2 =
    { elements = initAccordionElements
    , name = "accordion-2"
    , toggleSpeed = Slow
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


breadcrumbConfig1 =
    [ BreadcrumbElement "one" "http://www.google.com"
    , BreadcrumbElement "two" "#"
    , BreadcrumbElement "three" "#"
    , BreadcrumbElement "four" "#"
    , BreadcrumbElement "five" "#"
    ]


breadcrumbConfig2 =
    [ BreadcrumbElement "ten" "http://www.google.com"
    , BreadcrumbElement "nine" "#"
    ]


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
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


init1 : Accordion.State
init1 =
    { visible =
        [ ( 0, False )
        , ( 1, False )
        , ( 2, False )
        , ( 3, False )
        ]
    }


init2 : Accordion.State
init2 =
    { visible =
        [ ( 0, False )
        , ( 1, False )
        , ( 2, False )
        , ( 3, False )
        ]
    }


init : ( Model, Cmd Msg )
init =
    { accordion1 = init1
    , accordion2 = init2
    }
        ! []


accordionExamples : Model -> List (Html Msg)
accordionExamples model =
    [ h1 [] [ text "Accordion Examples" ]
    , App.map Accordion1 (Accordion.view model.accordion1 initAccordionData1)
    , App.map Accordion2 (Accordion.view model.accordion2 initAccordionData2)
    ]


horizontalRule : List (Html Msg)
horizontalRule =
    [ hr [] [] ]


breadcrumbExamples : List (Html Msg)
breadcrumbExamples =
    [ h1 [] [ text "Breadcrumb Examples" ]
    , Breadcrumb.view breadcrumbConfig1
    , Breadcrumb.view breadcrumbConfig2
    ]


view : Model -> Html Msg
view model =
    div [ style [ ( "width", "500px" ) ] ]
        (accordionExamples model
            ++ horizontalRule
            ++ breadcrumbExamples
        )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
