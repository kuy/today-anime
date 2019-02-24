open Core
open CalendarLib

type t = Syobocal.program

let to_string (program:t) =
  let count = Option.value ~default:"?" program.count in
  let subtitle = Option.value ~default:"[Untitled]" program.subtitle in
  sprintf "%s: %s [%s] %s" (Printer.Date.sprint "%Y/%m/%d" (Date.from_unixfloat @@ Float.of_string program.start_time)) program.title count subtitle