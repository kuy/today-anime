open Core
open Async

let list_of_syobocal_ids () =
  let%bind works = Annict_me.works ~season:"2019-winter" ~status:"watching" () in
  return @@ List.map ~f:(fun work -> work.syobocal_tid) works

let list_of_today's_animes ids =
  let%bind programs = Syobocal.programs () in
  let favorites = List.filter ~f:(fun program -> (List.count ~f:(fun id -> id = program.tid) ids) > 0) programs in
  return @@ List.iter ~f:Syobocal.print_program favorites

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