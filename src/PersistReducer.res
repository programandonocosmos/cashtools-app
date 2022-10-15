open ReactNativeAsyncStorage
open Utils
let dumpState = (key, state) =>
  switch Js.Json.stringifyAny(state) {
  | Some(encoded) => Ok(setItem(key, encoded))
  | None => Error("Could not encode state")
  }

let restoreState = key => getItem(key)->Promise.thenResolve(decodeJSStr)

let persistReducer = (key, reducer, state, action) => {
  let result = reducer(state, action)
  let _ = dumpState(key, result)
  result
}
