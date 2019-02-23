open Core
open Async

let list_of_syobocal_ids token =
  let%bind works = Annict_me.works ~season:"2019-winter" ~status:"watching" token in
  return @@ List.map ~f:(fun work -> work.syobocal_tid) works

let list_of_today's_animes ids ~more =
  let%bind programs = Syobocal.programs ~today:(not more) () in
  let favorites = List.filter ~f:(fun program -> (List.count ~f:(fun id -> id = program.tid) ids) > 0) programs in
  return @@ List.iter ~f:Syobocal.print_program favorites

let run ~more =
  let%bind config = Config.load () in
  let%bind ids = list_of_syobocal_ids config.annict.access_token in
  list_of_today's_animes ids ~more

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