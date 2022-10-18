open RescriptNativeBase
open Navigators.MainStack.Navigation
open Utils
module Mutation = %relay(`
  mutation LoginMutation($email: String!) {
    sendLoginCode(email: $email)
  }
`)
@react.component
let make = (~navigation: ReactNavigation.Core.navigation, ~route as _) => {
  let (email, setEmail) = React.useState(_ => "")

  let goToInsertion = _ => {
    navigate(navigation, "InsertCode")
  }

  let (mutate, isMutating) = Mutation.use()

  let onPressNext = _ =>
    mutate(
      ~variables={email: email},
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
    <Heading size=#"2xl" color="white"> {"Log In"->s} </Heading>
    <VStack width="100%">
      <Input
        value=email
        autoCapitalize=#none
        onChangeText={e => setEmail(_ => e)}
        placeholder="Email"
        keyboardType=#emailAddress
      />
      <Button
        alignSelf="flex-start"
        variant="ghost"
        onPress={_ => navigation->navigate("SignUp")}
        title="signup">
        {"Criar conta"->s}
      </Button>
    </VStack>
    <Box width="100%" justifyContent="flex-end">
      <Button title="advance" alignSelf="flex-end" maxW="100px" size=#md onPress={onPressNext}>
        {(isMutating ? "..." : "Avançar")->s}
      </Button>
    </Box>
  </Box>
}
