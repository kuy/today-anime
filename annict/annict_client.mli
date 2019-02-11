open Async

val make_url : string -> Uri.t

val get : Uri.t -> (Cohttp.Response.t * Cohttp_async.Body.t) Deferred.t