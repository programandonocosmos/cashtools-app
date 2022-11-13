open RescriptNativeBase
open Utils
open Navigators.MainStack.Navigation
open RescriptNativeBase.Toast
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
    navigateWithParams(navigation, "InsertCode", {email, username, name})
  }

  let (mutate, isMutating) = Mutation.use()
  let (dict, _) = Dict.use()
  let toast = useToast()
  let onPressNext = _ =>
    mutate(
      ~variables={email, username, name},
      ~onCompleted=(_, _) => goToInsertion(),
      ~onError=showRelayErrorMessage(dict, toast),
      (),
    )->ignore

  <Box
    justifyContent="space-between"
    alignItems="center"
    flex="1"
    variant="container"
    background="muted.900">
    <Heading size=#"2xl" color="white"> {"Cash Tools"->s} </Heading>
    <VStack space=4 width="100%">
      <Input value=name onChangeText={e => setName(_ => e)} placeholder={dict["name"]} />
      <Input
        value=username onChangeText={e => setUsername(_ => e)} placeholder={dict["username"]}
      />
      <Input
        value=email
        autoCapitalize=#none
        onChangeText={e => setEmail(_ => e)}
        placeholder="Email"
        keyboardType=#emailAddress
      />
      <Button
        marginTop="2"
        alignSelf="flex-start"
        onPress={_ => navigation->navigate("Login")}
        title="login">
        {dict["already_have_account"]->s}
      </Button>
    </VStack>
    <HStack width="100%" justifyContent="flex-end">
      <Button title="advance" alignSelf="flex-end" maxW="100px" size=#md onPress={onPressNext}>
        {(isMutating ? "..." : dict["next"])->s}
      </Button>
    </HStack>
  </Box>
}
