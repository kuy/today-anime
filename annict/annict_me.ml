open Async

let works ?season ?status token =
  let url = Annict_client.make_url "/v1/me/works" in
  let url = match season with
  | Some season -> Uri.add_query_param' url ("filter_season", season)
  | None -> url in
  let url = match status with
  | Some status -> Uri.add_query_param' url ("filter_status", status)
  | None -> url in
  Annict_client.get token url
  >>= fun (_, body) ->
  Cohttp_async.Body.to_string body
  >>| Annict_me_j.works_payload_of_string
  >>| fun payload ->
  payload.works