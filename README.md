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

### Options

#### `--more`

You couldn't watch animes yesterday? No problem, just add this option to show all past 5 days.


## API

### Run

`today-anime-api`

### Endpoints

#### `/today`

`curl -X GET http://localhost:8080/today`


## Development

### Module structure

- `cli`: CLI application executable
- `api`: REST API server executable
- `app`: Core application module
- `annict`: Annict API wrapper
- `syobocal`: Syoboi Calendar API wrapper

### Requirements

- OCaml 4.07.1
- opam 2.0.x
- dune 1.6.x

### Prepare

Create an environment using [opam](https://opam.ocaml.org/doc/Usage.html#opam-switch).

### CLI

#### Run

`dune exec cli/main.exe`

### API

#### Run

`dune exec api/main.exe`