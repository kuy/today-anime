type t = Config_t.body

val create : string -> t

val load : unit -> t Async.Deferred.t