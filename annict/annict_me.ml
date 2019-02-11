open Async

let works ?season ?status () =
  let url = Annict.make_url "/v1/me/works" in
  let url = match season with
  | Some season -> Uri.add_query_param' url ("filter_season", season)
  | None -> url in
  let url = match status with
  | Some status -> Uri.add_query_param' url ("filter_status", status)
  | None -> url in
  let headers = Cohttp.Header.init_with "Authorization" "Bearer <TOKEN>" in
  Cohttp_async.Client.get ~headers: headers url
  >>= fun (_, body) ->
  Cohttp_async.Body.to_string body
  >>| Annict_me_j.works_payload_of_string
  >>| fun payload ->
  payload.works