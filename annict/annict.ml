open Core
open Async

let base_url = "https://api.annict.com"

let make_url path = Uri.of_string (base_url ^ path)

let works ?season () =
  let url = make_url "/v1/works" in
  let url = match season with
  | Some season -> Uri.add_query_param' url ("filter_season", season)
  | None -> url in
  let headers = Cohttp.Header.init_with "Authorization" "Bearer <TOKEN>" in
  Cohttp_async.Client.get ~headers: headers url
  >>= fun (_, body) ->
  Cohttp_async.Body.to_string body
  >>| Annict_j.works_payload_of_string
  >>| fun payload ->
  payload.works