/* RelayEnv.res */

/* This is just a custom exception to indicate that something went wrong. */
exception Graphql_error(string)

/**
 * A standard fetch that sends our operation and variables to the
 * GraphQL server, and then decodes and returns the response.
 */
let fetchQuery: RescriptRelay.Network.fetchFunctionPromise = (
  operation,
  variables,
  _cacheConfig,
  _uploadables,
) => {
  open Fetch
  fetchWithInit(
    Env.apiUrl,
    RequestInit.make(
      ~method_=Post,
      ~body=Js.Dict.fromList(list{
        ("query", Js.Json.string(operation.text)),
        ("variables", variables),
      })
      ->Js.Json.object_
      ->Js.Json.stringify
      ->BodyInit.make,
      ~headers=HeadersInit.make({
        "content-type": "application/json",
        "accept": "application/json",
      }),
      (),
    ),
  ) |> Js.Promise.then_(resp =>
    if Response.ok(resp) {
      Response.json(resp)
    } else {
      Js.Promise.reject(Graphql_error("Request failed: " ++ Response.statusText(resp)))
    }
  )
}

let network = RescriptRelay.Network.makePromiseBased(~fetchFunction=fetchQuery, ())

let environment = RescriptRelay.Environment.make(
  ~network,
  ~store=RescriptRelay.Store.make(
    ~source=RescriptRelay.RecordSource.make(),
    ~gcReleaseBufferSize=10 /* This sets the query cache size to 10 */,
    (),
  ),
  (),
)
module Query = %relay(`
query RelayEnvCheckQuery {
  apiVersion
}
`)
Query.fetchPromised(~environment, ~variables=(), ())
->Promise.thenResolve(response =>
  Js.Console.log("Starting app... API version: " ++ response.apiVersion)
)
->Promise.catch(err =>
  Js.Console.error(
    `Error while getting API version:  ${Js.String.make(
        Js.Json.stringifyAny(err),
      )}. Server address: ${Env.apiUrl}`,
  )->Promise.resolve
)
->ignore
