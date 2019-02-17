open Async

val make_url : string -> Uri.t

val get : string -> Uri.t -> (Cohttp.Response.t * Cohttp_async.Body.t) Deferred.t