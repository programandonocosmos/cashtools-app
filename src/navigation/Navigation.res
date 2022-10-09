open ReactNavigation
module MainStackScreen = {
  module StakeParams = {
    type params = {name: string}
  }
  include Stack.Make(StakeParams)

  @react.component
  let make = (~navigation as _, ~route as _) => {
    let (state, _dispatch) = Context.AuthContext.use()

    <Navigator screenOptions={_optionsProps => options(~headerShown=false, ())}>
      {switch state {
      | UserDomain.LoggedIn(_) => <Screen name="Home" component=Home.make />
      | UserDomain.LoggedOut => <Screen name="Login" component=Login.make />
      }}
    </Navigator>
  }
}

module RootStackScreen = {
  include Stack.Make({
    type params = unit
  })
  @react.component
  let make = () =>
    <Native.NavigationContainer>
      <Navigator screenOptions={_optionsProps => options(~headerShown=false, ())}>
        <Screen name="Stack" component=MainStackScreen.make />
      </Navigator>
    </Native.NavigationContainer>
}
