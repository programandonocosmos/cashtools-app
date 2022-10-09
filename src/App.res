open UserDomain
@react.component
let make = _ => {
  let contextVal = React.useReducer(AuthReducer.reducer, LoggedIn(dummyUser))

  <Context.AuthContext.Provider value=contextVal>
    <Navigation.RootStackScreen />
  </Context.AuthContext.Provider>
}

let default = make
