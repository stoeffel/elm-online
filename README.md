elm-online
==========

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
