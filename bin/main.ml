open Lib
open Async

let run =
  (*Annict.list_of_watching ()
  >>| fun works ->
  List.iter (fun (work : Annict_t.work) -> print_endline work.title) works*)
  Syoboi.list_of_programs ()
  >>| fun programs ->
  List.iter (fun (prog : Syoboi_rss2_t.program) -> print_endline prog.title) programs

let () =
  Command.async_spec
    ~summary: "Fetch my watch list of this season"
    Command.Spec.(
      empty
    )
    (fun () -> run)
  |> Command.run