open Async

let works ?season token =
  let url = Annict_client.make_url "/v1/works" in
  let url = match season with
  | Some season -> Uri.add_query_param' url ("filter_season", season)
  | None -> url in
  Annict_client.get token url
  >>= fun (_, body) ->
  Cohttp_async.Body.to_string body
  >>| Annict_j.works_payload_of_string
  >>| fun payload ->
  payload.works