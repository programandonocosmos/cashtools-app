let safelyParseJSON = json =>
  switch Js.Json.deserializeUnsafe(json) {
  | json => Some(json)
  | exception _ => None
  }

let decodeJSStr = maybeStr => Js.nullToOption(maybeStr)->Belt.Option.flatMap(safelyParseJSON)
