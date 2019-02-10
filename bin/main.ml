open Lib
open Async

let run =
  Annict.list_of_watching ()
  >>| fun works ->
  List.iter (fun (work : Annict_t.work) -> print_endline work.title) works

let () =
  Command.async_spec
    ~summary: "Fetch my watch list of this season"
    Command.Spec.(
      empty
    )
    (fun () -> run)
  |> Command.run