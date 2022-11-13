let safelyParseJSON = json =>
  switch Js.Json.deserializeUnsafe(json) {
  | json => Some(json)
  | exception _ => None
  }

let decodeJSStr = maybeStr => Js.nullToOption(maybeStr)->Belt.Option.flatMap(safelyParseJSON)
let s = React.string
let showRelayErrorMessage = (dict, toast, e:RescriptRelay.mutationError) => toast->RescriptNativeBase.Toast.show({
  title: dict["unknown_error"]++ e.message,
})->ignore