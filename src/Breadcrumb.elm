module Breadcrumb exposing (view, BreadcrumbConfig, BreadcrumbElement)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias BreadcrumbElement =
    { label : String
    , href : String
    }


type alias BreadcrumbConfig =
    List BreadcrumbElement


breadcrumbItem : BreadcrumbElement -> Html a
breadcrumbItem config =
    a [ href config.href ] [ text config.label ]


view : BreadcrumbConfig -> Html msg
view config =
    div []
        [ div
            [ class "breadcrumb" ]
            (List.map breadcrumbItem config)
        ]
