open Core
open Async
open Httpaf
open Httpaf_async

let error_handler _ ?request:_ error start_response =
  let response_body = start_response Headers.empty in
  begin match error with
  | `Exn exn ->
    Body.write_string response_body (Exn.to_string exn);
    Body.write_string response_body "\n";
  | #Status.standard as error ->
    Body.write_string response_body (Status.default_reason_phrase error)
  end;
  Body.close_writer response_body

let request_handler _ reqd =
  match Reqd.request reqd  with
  | { meth = `GET; target; _ } ->
    let uri = Uri.of_string target in
    (
      match Uri.path uri with
      | "/today" ->
        let headers = Headers.of_list ["content-type", "application/json"; "connection", "close"] in
        let res = Response.create ~headers `OK in
        let config = Config.create "<TOKEN>" in
        App.today's_anime config
        >>> fun programs ->
        let programs = List.map ~f:Convert.to_program programs in
        let data = ({ status = 200; items = programs; } : Api_t.programs_response) in
        Reqd.respond_with_string reqd res (Api_j.string_of_programs_response data)
      | _ ->
        let headers = Headers.of_list ["connection", "close"] in
        let res = Response.create ~headers `Not_found in
        Reqd.respond_with_string reqd res ""
    )
  | _ -> Reqd.respond_with_string reqd (Response.create `Method_not_allowed) ""

let app ~port =
  let where_to_listen = Tcp.Where_to_listen.of_port port in
  Tcp.(Server.create_sock ~on_handler_error:`Raise
      ~backlog:10_000 ~max_connections:10_000 ~max_accepts_per_batch:1 where_to_listen)
    (Server.create_connection_handler ~request_handler ~error_handler)
  >>= fun _server ->
  Deferred.never ()

let () =
  Command.async_spec
    ~summary: "Start REST API server"
    Command.Spec.(
      empty
      +> flag "--port" (optional_with_default 8080 int)
        ~doc: "int listen port (default: 8080)"
    )
    (fun port () -> app ~port)
  |> Command.run