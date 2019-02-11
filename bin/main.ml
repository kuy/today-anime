open Lib
open Core
open Async

let list_of_syobocal_ids () =
  let%bind works = Annict.list_of_watching () in
  return @@ List.map ~f:(fun (work : Annict_t.work) -> work.syobocal_tid) works

let list_of_today's_animes ids =
  let%bind programs = Syoboi.list_of_programs () in
  let favorites = List.filter ~f:(fun (program : Syoboi_rss2_t.program) -> (List.count ~f:(fun id -> id = program.tid) ids) > 0) programs in
  return @@ List.iter ~f:(fun (program : Syoboi_rss2_t.program) -> print_endline program.title) favorites

let run =
  let%bind ids = list_of_syobocal_ids () in
  list_of_today's_animes ids

let () =
  Command.async_spec
    ~summary: "Fetch my watch list of this season"
    Command.Spec.(
      empty
    )
    (fun () -> run)
  |> Command.run