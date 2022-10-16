open RescriptNativeBase
open UserDomain
open ReactNavigation
open Utils

module Mutation = %relay(`
  mutation LoginMutation($email: String!, $username: String!, $name: String!) {
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
    mutate(~variables={email, username, name}, ~onCompleted=(_, _) => goToInsertion(), ())->ignore
  <Box
    justifyContent="space-between"
    // padding="24px"
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
    // variant={#filled}
      value=email
      autoCapitalize=#none
      onChangeText={e => setEmail(_ => e)}
      // color="white"
      placeholder="Email"
      keyboardType=#emailAddress
    />
    // <CContainer width="100%" justifyContent="flex-end" />
    <Box width="100%" justifyContent="flex-end">
      <Button
        title="advance"
        alignSelf="flex-end"
        maxW="100px"
        size=#md
        // onPress={ _ => ()}
        onPress={onPressNext}>
        {(isMutating ? "..." : "Avançar")->s}
      </Button>
    </Box>
  </Box>
}
