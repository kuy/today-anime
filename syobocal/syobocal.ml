open Core
open Async
open CalendarLib

let map_t f (a, b) = (f a, f b)

let base_url = "http://cal.syoboi.jp"

let string_of_date d = Printer.Date.sprint "%Y%m%d" d

let query_url range =
  let (from_d, to_d) = map_t string_of_date range in
  sprintf "%s/rss2.php?start=%s2200&end=%s1800&alt=json" base_url from_d to_d
  |> Uri.of_string

let within_days n =
  let today = Date.today () in
  let days_ago = Date.rem today (Date.Period.day n) in
  (days_ago, today)

let asc_start (p1:Syobocal_rss2_t.program) (p2:Syobocal_rss2_t.program) =
  (Int.of_string p1.start_time) - (Int.of_string p2.start_time)

let asc_tid (p1:Syobocal_rss2_t.program) (p2:Syobocal_rss2_t.program) =
  (Int.of_string p1.tid) - (Int.of_string p2.tid)

let by_today (p:Syobocal_rss2_t.program) =
  (Unix.time ()) -. (Float.of_int (24 * 60 * 60)) < (Float.of_string p.start_time)

let print_program (p:Syobocal_rss2_t.program) =
  let count = Option.value ~default:"?" p.count in
  let subtitle = Option.value ~default:"[Untitled]" p.subtitle in
  printf "%s: %s [%s] %s\n" (CalendarLib.Printer.Date.sprint "%Y/%m/%d" (CalendarLib.Date.from_unixfloat @@ Float.of_string p.start_time)) p.title count subtitle

let programs ?range () =
  let range = Option.value ~default:(within_days 3) range in
  query_url range
  |> Cohttp_async.Client.get
  >>= fun (_, body) ->
  Cohttp_async.Body.to_string body
  >>| Syobocal_rss2_j.programs_payload_of_string
  >>| fun payload ->
  payload.programs
  |> List.dedup_and_sort ~compare:asc_tid
  |> List.dedup_and_sort ~compare:asc_start
  |> List.filter ~f:by_today