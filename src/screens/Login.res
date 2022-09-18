open RescriptNativeBase
let s = React.string
@react.component
let make = (~navigation as _, ~route as _) => {
  let (email, setEmail) = React.useState(_ => "")

  <Box justifyContent="space-between" flex="1" background="muted.900">
    <Heading size=#"2xl" color="white"> {"Cash App"->s} </Heading>
    <Input
      value=email
      onChangeText={e => setEmail(_ => e)}
      color="white"
      placeholder="Email"
      keyboardType=#emailAddress
    />
    <Button title="avançar" onPress={_ => Js.Console.log("lets go")} />
  </Box>
}
