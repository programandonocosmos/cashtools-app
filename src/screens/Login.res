open RescriptNativeBase
open UserDomain
let s = React.string

module Query = %relay(`
  query LoginQuery ($email: String!, $loginCode: Int!) {
  	token(email: $email, loginCode: $loginCode)
  }
`)

@react.component
let make = (~navigation as _, ~route as _) => {
  let (email, setEmail) = React.useState(_ => "")
  let (_state, dispatch) = Context.AuthContext.use()

  let result = Query.use(
    ~variables={
      email,
      loginCode: 1234,
    },
    (),
  )

  <Box
    justifyContent="space-between"
    padding="24px"
    alignItems="center"
    flex="1"
    background="muted.900">
    <Heading size=#"2xl" color="white"> {"Cash Tools"->s} </Heading>
    <Input
      variant=#outline
      value=email
      onChangeText={e => setEmail(_ => e)}
      color="white"
      placeholder="Email"
      keyboardType=#emailAddress
    />
    <Box width="100%" justifyContent="flex-end">
      <Button
        title="advance"
        alignSelf="flex-end"
        maxW="100px"
        size=#md
        onPress={_ => dispatch(AuthReducer.Login(dummyUser))}>
        {"Avançar"->s}
      </Button>
    </Box>
  </Box>
}
