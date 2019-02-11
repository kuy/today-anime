open Core

let access_token = "<YOUR ACCESS TOKEN>"

let base_url = "https://api.annict.com"

let make_url path = Uri.of_string (base_url ^ path)

let get url =
  let headers = Cohttp.Header.init_with "Authorization" ("Bearer " ^ access_token) in
  Cohttp_async.Client.get ~headers: headers url