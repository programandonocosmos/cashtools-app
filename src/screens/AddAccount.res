open ReactNative
@react.component
let make = (~navigation as _, ~route as _) =>
  <Text> {j`Hello Reasonable Person!`->React.string} </Text>
