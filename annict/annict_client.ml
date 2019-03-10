open Core

let base_url = "https://api.annict.com"

let make_url path = Uri.of_string (base_url ^ path)

let get token url =
  let config = Conduit_async.V2.Ssl.Config.create ~hostname: "api.annict.com" () in
  let headers = Cohttp.Header.init_with "Authorization" ("Bearer " ^ token) in
  Cohttp_async.Client.get ~ssl_config: config ~headers: headers url