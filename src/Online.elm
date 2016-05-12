effect module Online where { subscription = MySub } exposing (changes)

{-| Subscribe to online/offline changes
[online and offline events]: https://developer.mozilla.org/en/docs/Online_and_offline_events
# Subscribe to Changes
@docs changes
-}

import Native.Online
import Process
import Task exposing (Task)


type alias IsOnline =
    Bool


listen : (IsOnline -> Task Never ()) -> (a -> Task Never ()) -> Task x Never
listen =
    Native.Online.listen


type MySub msg
    = Tagger (IsOnline -> msg)


subMap : (a -> b) -> MySub a -> MySub b
subMap func (Tagger tagger) =
    Tagger (tagger >> func)


{-| Use `changes` to subscribe to online/offline changes
    type Msg = ChangeOnline Bool | ...
    subscriptions _ = Online.changes ChangeOnline
-}
changes : (IsOnline -> msg) -> Sub msg
changes tagger =
    subscription (Tagger tagger)



-- EFFECT MANAGER


type alias State msg =
    Maybe
        { subs : List (MySub msg)
        , listener : Process.Id
        }


init : Task Never (State msg)
init =
    Task.succeed Nothing


onEffects : Platform.Router msg IsOnline -> List (MySub msg) -> State msg -> Task Never (State msg)
onEffects router subs state =
    case state of
        Nothing ->
            case subs of
                [] ->
                    Task.succeed state

                _ ->
                    Process.spawn (listen (Platform.sendToSelf router) (\_ -> Task.succeed ()))
                        `Task.andThen` \listener ->
                                        Task.succeed (Just { subs = subs, listener = listener })

        Just { subs, listener } ->
            case subs of
                [] ->
                    Process.kill listener
                        `Task.andThen` \_ ->
                                        Task.succeed Nothing

                _ ->
                    Task.succeed (Just { subs = subs, listener = listener })


onSelfMsg : Platform.Router msg IsOnline -> IsOnline -> State msg -> Task Never (State msg)
onSelfMsg router location state =
    case state of
        Nothing ->
            Task.succeed Nothing

        Just { subs } ->
            let
                send (Tagger tagger) =
                    Platform.sendToApp router (tagger location)
            in
                Task.sequence (List.map send subs)
                    `Task.andThen` \_ ->
                                    Task.succeed state
