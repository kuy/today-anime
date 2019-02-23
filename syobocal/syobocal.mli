open CalendarLib

type program = Syobocal_rss2_t.program

val programs : ?today:bool -> ?range:(Date.t * Date.t) -> unit -> Syobocal_rss2_t.programs Async.Deferred.t