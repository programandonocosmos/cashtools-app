open Belt
open Utils
open RescriptNativeBase
open InsertCodeQuery_graphql.Types
open RescriptNativeBase.Toast

module InsertCodeQuery = %relay(`
  query InsertCodeQuery($email: String!, $loginCode: Int!) {
    token(email: $email, loginCode: $loginCode)
  }
`)
module MeQuery = %relay(`
  query InsertCodeReadUserQuery($token: String!) {
    me(token: $token) {
      email
      username
      name
    }
  }
`)

let fetchToken = (loginCode, email) =>
  InsertCodeQuery.fetchPromised(
    ~environment=RelayEnv.environment,
    ~variables={loginCode, email},
    (),
  )

let fetchMe = token =>
  MeQuery.fetchPromised(~environment=RelayEnv.environment, ~variables={token: token}, ())

@react.component
let make = (~navigation, ~route: Navigators.MainStack.route) => {
  let (login, _, _) = Hooks.useAuth()
  let (dict, _) = Dict.use()

  let (code, setCode) = React.useState(_ => "")
  let toast = useToast()
  let onError = err => {
    Js.Console.log(err)
    toast
    ->show({
      title: switch Js.Json.stringifyAny(err) {
      | None => dict["failed_to_login"]
      | Some(v) => v
      },
    })
    ->ignore
  }
  let gotoHome = _ => navigation->Navigators.MainStack.Navigation.navigate("Home")

  let saveUserAndRedirect = ({username, name, token}: UserDomain.userInfo) => {
    login({username, name, token})
    gotoHome()
  }

  let fetchUserDetailsAndLogin = token =>
    fetchMe(token)->Promise.thenResolve(({me: {username, name}}) =>
      saveUserAndRedirect({username, name, token})
    )

  let onClickNext = _ => {
    switch (Int.fromString(code), route.params) {
    | (Some(loginCode), Some({email, username: ?Some(username), name: ?Some(name)})) => {
    
        fetchToken(loginCode, email)
        ->Promise.thenResolve(({token}) => saveUserAndRedirect({username, name, token}))
        ->Promise.catch(e => onError(e)->Promise.resolve)
        ->ignore
      }

    | (Some(loginCode), Some({email, _})) => {
    
        fetchToken(loginCode, email)
        ->Promise.then(({token}) => {
          fetchUserDetailsAndLogin(token)
        })
        ->Promise.catch(e => onError(e)->Promise.resolve)
        ->ignore
      }

    | (None, _) =>
      toast
      ->show({
        title: dict["invalid_code"],
      })
      ->ignore

    | (Some(_), None) => toast->Toast.show({title: dict["invalid_route_params"]})->ignore
    
    }
  }

  <Box justifyContent="space-between" variant="container">
    <Heading size=#"2xl"> {dict["enter_code_email"]->s} </Heading>
    <Input
      keyboardType=#decimalPad
      onSubmitEditing=onClickNext
      value=code
      onChangeText={t => setCode(_ => t)}
    />
    <HStack justifyContent="flex-end" space=2>
      <Button title="back" onPress={_ => navigation->Navigators.MainStack.Navigation.goBack()}>
        <Typography> {dict["back"]} </Typography>
      </Button>
      <Button alignSelf="flex-end" title="logout button" onPress={onClickNext}>
        <Typography> {dict["next"]} </Typography>
      </Button>
    </HStack>
  </Box>
}
