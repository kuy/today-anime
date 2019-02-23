open Core
open Async

let run ~more =
  let%bind config = Config.load () in
  let%bind programs = App.today's_anime ~more config in
  return @@ List.iter ~f:print_endline programs

let () =
  Command.async_spec
    ~summary: "Fetch my watch list of this season"
    Command.Spec.(
      empty
      +> flag "--more" no_arg
        ~doc: " Show more items"
    )
    (fun more () -> run ~more)
  |> Command.run