open ReactNavigation
open Navigators
open UserDomain
module MainStackScreen = {
  include MainStack
  @react.component
  let make = (~navigation as _, ~route as _) => {
    let (_login, _logout, state) = Hooks.useAuth()
    // let state = Auth.LoggedIn(UserDomain.dummyUser)
    <Navigator screenOptions={_optionsProps => options(~headerShown=false, ())}>
      {switch state {
      | Auth.LoggedIn(_) =>
        <>
          <Screen name="AddAccount" component=AddAccount.make />
          <Screen name="Home" component=Home.make />
        </>
      | Auth.LoggedOut =>
        <>
          <Screen name="SignUp" component=SignUp.make />
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
