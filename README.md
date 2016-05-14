elm-online
==========

> Subscribe to online/offline changes in your apps.  
> `elm-online` wraps "online" and "offline" events from the browser ([see mdn/Online_and_offline_events](https://developer.mozilla.org/en/docs/Online_and_offline_events)).

## Example

Run the example in elm-reactor like this:

```bash
$ cd examples
$ elm-reactor
```

## Usage

```elm
import Online


type Msg = ChangeOnline Bool | ...
subscriptions _ = Online.changes ChangeOnline
```

This is based on [elm-lang/geolocation](https://github.com/elm-lang/geolocation) original [license](./LICENSE_GEOLOCATION) is included in this repo.
