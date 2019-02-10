open Core
open Async

let base_url = "https://api.annict.com"

let query_url path = Uri.of_string (base_url ^ path)

let list_of_watching () =
  let url = query_url "/v1/me/works?filter_status=watching&filter_season=2019-winter" in
  let headers = Cohttp.Header.init_with "Authorization" "Bearer <YOUR ACCESS TOKEN>" in
  Cohttp_async.Client.get ~headers: headers url
  >>= fun (_, body) ->
  Cohttp_async.Body.to_string body
