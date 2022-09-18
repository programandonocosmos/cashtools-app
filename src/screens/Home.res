open ReactNative
@react.component
let make = (~navigation as _, ~route as _) =>
  <RescriptNativeBase.Box flex="1" background="muted.700">
    <Text> {j`To no home`->React.string} </Text>
  </RescriptNativeBase.Box>
