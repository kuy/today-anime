open Async

val make_url : string -> Uri.t

val works : ?season:string -> unit -> Annict_t.works Deferred.t