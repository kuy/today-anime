open Async
open Core

type t = Config_t.body

exception File_not_found

let create token = ({ annict = { access_token = token } } : t)

let load () =
  let home = Sys.getenv_exn "HOME" in
  let path = home ^ "/.today-anime.json" in
  match Sys.is_file path with
  | `Yes ->
    Reader.file_contents path
    >>| Config_j.body_of_string
  | _ -> raise File_not_found