open ReactNavigation
open Navigators
module MainStackScreen = {
  include MainStack
  @react.component
  let make = (~navigation as _, ~route as _) => {
    let (state, _dispatch) = Context.AuthContext.use()

    <Navigator screenOptions={_optionsProps => options(~headerShown=false, ())}>
      {switch state {
      | UserDomain.LoggedIn(_) => <Screen name="Home" component=Home.make />
      | UserDomain.LoggedOut =>
        <>
          <Screen name="Login" component=Login.make />
          <Screen name="InsertCode" component=InsertCode.make />
        </>
      }}
    </Navigator>
  }
}

module RootStackScreen = {
  include RootStack
  @react.component
  let make = () =>
    <Native.NavigationContainer theme={ReactNavigation.Native.darkTheme}>
      <Navigator
        screenOptions={_optionsProps => options(~headerShown=false, ~presentation=#modal, ())}>
        <Screen name="Stack" component=MainStackScreen.make />
      </Navigator>
    </Native.NavigationContainer>
}
// 
