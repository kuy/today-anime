open Lib
open Async

let run =
  let do_request =
    let result = Annict.list_of_watching () in
    Deferred.upon result (fun body ->
    print_endline body) in
  ignore do_request;
  Deferred.never ()

let () =
  Command.async_spec
    ~summary: "Fetch my watch list of this season"
    Command.Spec.(
      empty
    )
    (fun () -> run)
  |> Command.run