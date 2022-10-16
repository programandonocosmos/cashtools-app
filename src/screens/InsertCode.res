open RescriptNativeBase
module Query = %relay(`
  query InsertCodeQuery($email: String!, $loginCode: Int!) {
    token(email: $email, loginCode: $loginCode)
  }
`)
open InsertCodeQuery_graphql.Types
open Belt

@react.component
let make = (~navigation, ~route: Navigators.MainStack.route) => {
  let (login, _, _) = Hooks.useAuth()
  let (code, setCode) = React.useState(_ => "")

  let {email, username, name} = switch route.params {
  | Some(params) => params
  // TODO: handle this
  | None => failwith("invalid params")
  }

  let gotoHome = _ => navigation->Navigators.MainStack.Navigation.navigate("Home")

  let onQuerySucceed = res =>
    switch res {
    | Ok({token}) => {
        login({username, name, token})
        gotoHome()
      }

    | Error(e) => Js.log(e)
    }

  let onClickNext = _ => {
    switch Int.fromString(code) {
    | Some(loginCode) =>
      Query.fetch(
        ~environment=RelayEnv.environment,
        ~variables={loginCode, email},
        ~onResult=onQuerySucceed,
        (),
      )
    | None => ()
    }->ignore
  }

  <Box justifyContent="space-between" variant="container">
    <Heading size=#"2xl">
      {j`Digite o código
enviado no 
seu email`->React.string}
    </Heading>
    <Input keyboardType=#decimalPad value=code onChangeText={t => setCode(_ => t)} />
    <HStack justifyContent="flex-end" space=2>
      <Button title="back" onPress={_ => navigation->Navigators.MainStack.Navigation.goBack()}>
        <Text> {`Voltar`->React.string} </Text>
      </Button>
      <Button alignSelf="flex-end" title="logout button" onPress={onClickNext}>
        <Text> {j`Avançar`->React.string} </Text>
      </Button>
    </HStack>
  </Box>
}
