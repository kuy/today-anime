open Lib
open Async

let run =
  Annict.list_of_watching ()
  >>| fun body ->
  print_endline body

let () =
  Command.async_spec
    ~summary: "Fetch my watch list of this season"
    Command.Spec.(
      empty
    )
    (fun () -> run)
  |> Command.run