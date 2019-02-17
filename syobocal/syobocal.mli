open Async
open CalendarLib

val print_program : Syobocal_rss2_t.program -> unit

val programs : ?range:(Date.t * Date.t) -> unit -> Syobocal_rss2_t.programs Deferred.t