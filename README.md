# today-anime?

**I can't keep in mind a day of the week of my favorite animes' broadcast 😇**

## Requirements

- OCaml 4.07.1
- opam 2.0.x
- dune 1.6.x

## Prepare

Create an environment using [opam](https://opam.ocaml.org/doc/Usage.html#opam-switch).

Get an [access token](https://docs.annict.com/ja/api/v1/authentication.html) from Annict.

Set it [here](https://github.com/kuy/today-anime/blob/master/annict/annict_client.ml#L3) in `annict/annict_client.ml` file.

## Usage

Run `dune exec bin/main.exe`.
