open RescriptNativeBase
open Utils

module Mutation = %relay(`
  mutation SignUpMutation($email: String!, $username: String!, $name: String!) {
    createUser(email: $email, username: $username, name: $name) {
      id
    }
  }
`)

@react.component
let make = (~navigation: ReactNavigation.Core.navigation, ~route as _) => {
  let (email, setEmail) = React.useState(_ => "")
  let (username, setUsername) = React.useState(_ => "")
  let (name, setName) = React.useState(_ => "")
  let goToInsertion = _ => {
    Navigators.MainStack.Navigation.navigateWithParams(
      navigation,
      "InsertCode",
      {email, username, name},
    )
  }

  let (mutate, isMutating) = Mutation.use()

  let onPressNext = _ =>
    mutate(
      ~variables={email, username, name},
      ~onCompleted=(_, _) => goToInsertion(),
      ~onError=err => Js.log(Js.Json.stringifyAny(err.message)),
      (),
    )->ignore

  <Box
    justifyContent="space-between"
    alignItems="center"
    flex="1"
    variant="container"
    background="muted.900">
    <Heading size=#"2xl" color="white"> {"Cash Tools"->s} </Heading>
    <Input value=name onChangeText={e => setName(_ => e)} placeholder="Nome" />
    <Input
      value=username
      onChangeText={e => setUsername(_ => e)}
      placeholder="Username"
      keyboardType=#emailAddress
    />
    <Input
      value=email
      autoCapitalize=#none
      onChangeText={e => setEmail(_ => e)}
      placeholder="Email"
      keyboardType=#emailAddress
    />
    <Box width="100%" justifyContent="flex-end">
      <Button title="advance" alignSelf="flex-end" maxW="100px" size=#md onPress={onPressNext}>
        {(isMutating ? "..." : "Avançar")->s}
      </Button>
    </Box>
  </Box>
}
