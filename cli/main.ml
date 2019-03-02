open Core
open Async

let run ~more =
  let%bind config = Config.load () in
  let%bind programs = App.today's_anime ~more config in
  return @@ List.iter ~f:(fun p -> print_endline (Program.to_string p)) programs

let run_version () =
  return @@ print_endline @@ App.version ()

let () =
  Command.async_spec
    ~summary: "Fetch my watch list of this season"
    Command.Spec.(
      empty
      +> flag "--more" no_arg
        ~doc: " Show more items"
      +> flag "--version" no_arg
        ~doc: " Show version info"
    )
    (fun more version () ->
    if version then run_version ()
    else run ~more)
  |> Command.run