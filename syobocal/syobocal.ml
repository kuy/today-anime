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

let range_of_today () =
  let today = Date.today () in
  let yesterday = Date.prev today `Day in
  (yesterday, today)

let list_of_programs () =
  query_url @@ range_of_today ()
  |> Cohttp_async.Client.get
  >>= fun (_, body) ->
  Cohttp_async.Body.to_string body
  >>| Syobocal_rss2_j.programs_payload_of_string
  >>| fun payload ->
  payload.programs