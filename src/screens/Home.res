open RescriptNativeBase
@react.component
let make = (~navigation as _, ~route as _) => {
  let (_state, dispatch) = Context.AuthContext.use()
  <Box flex="1" background="muted.700">
    <Text> {j`Im Home`->React.string} </Text>
    <Button title="logout button" onPress={_ => dispatch(AuthReducer.Logout)}>
      <Text> {j`Logout`->React.string} </Text>
    </Button>
  </Box>
}
