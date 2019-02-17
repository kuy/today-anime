open Async

val works : ?season:string -> ?status:string -> string -> Annict_me_t.works Deferred.t