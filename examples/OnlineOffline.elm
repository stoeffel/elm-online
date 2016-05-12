module Main exposing (..)

import Html exposing (div, h1, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Task exposing (..)
import Process
import Time exposing (..)
import Online





subscriptions : Model -> Sub Msg
subscriptions _ = Online.changes ChangeOnline



-- MODEL


init : ( Model, Cmd Msg )
init  =
    ( { isOnline = False}, Cmd.none )


type alias Model =
    { isOnline : Bool
    }



-- ACTIONS


type Msg
    = NoOp
    | ChangeOnline Bool



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        ChangeOnline online ->
            ( { model | isOnline = online }, Cmd.none)

        NoOp ->
            ( model, Cmd.none )




-- START STORE
-- fake view needed for startapp


view : Model -> Html.Html Msg
view model =
  let
      online =
          case model.isOnline of
              True -> ("lightgreen", "Online")
              False -> ("grey", "Offline")
  in
    div [ styles <| fst online]
      [ h1 [] [ text <| snd online]
      ]


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


styles color = style 
  [ ("height", "100%")
  , ( "width","100%" )
  , ( "position","absolute" )
  , ( "background", color)
  ]
