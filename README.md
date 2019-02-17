# today-anime?

**I can't keep in mind a day of the week of my favorite animes' broadcast 😇**

## Usage

### Installation

Download a latest binary from [Releases](https://github.com/kuy/today-anime/releases) page and extract it anywhere you want.
I recommend you to put the binary at a directory which is already in PATH env.

### Configuration

This application requires [Annict's Personal Access Token](https://annict.jp/settings/apps) to get your programs that is watching now.

To provide the access token to the application, put `.today-anime.json` file to your home directory. Here is an example of the configuration file.

```json
{
  "annict" : {
    "accessToken": "ANNICT ACCESS TOKEN"
  }
}
```

### Run

Simply run `today-anime`.


## Development

### Requirements

- OCaml 4.07.1
- opam 2.0.x
- dune 1.6.x

### Prepare

Create an environment using [opam](https://opam.ocaml.org/doc/Usage.html#opam-switch).

### Run

Run `dune exec bin/main.exe`.
