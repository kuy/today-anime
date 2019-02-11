open Async

val works : ?season:string -> ?status:string -> unit -> Annict_me_t.works Deferred.t