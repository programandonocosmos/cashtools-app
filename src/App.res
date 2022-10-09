open UserDomain
@react.component
let make = _ => {
  let contextVal = React.useReducer(AuthReducer.reducer, LoggedIn(dummyUser))

  <Context.AuthContext.Provider value=contextVal>
    <RescriptRelay.Context.Provider environment=RelayEnv.environment>
      <Navigation.RootStackScreen />
    </RescriptRelay.Context.Provider>
  </Context.AuthContext.Provider>
}

let default = make
