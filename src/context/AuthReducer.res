open UserDomain
open Belt

let initialState = Auth.LoggedOut

type action = Login(userInfo) | Logout | Hydratate(Auth.states)

let dummyDispatch = (_: action) => ()

let reducer = (_state: Auth.states, action) => {
  open Auth
  switch action {
  | Login(user) => LoggedIn(user)
  | Logout => LoggedOut
  | Hydratate(authState) => authState
  }
}

let ppState = (state: Auth.states) => {
  switch state {
  | LoggedIn(user) => "Logged in as " ++ Js.Json.serializeExn(user)
  | LoggedOut => "Logged out"
  }
}

let persistedReducer = PersistReducer.persistReducer("auth", reducer)

let use = () => {
  let (state, dispatch) = React.useReducer(persistedReducer, LoggedIn(dummyUser))

  React.useEffect1(() => {
    PersistReducer.restoreState("auth")
    ->Promise.thenResolve(maybeState =>
      Option.map(maybeState, freshState => dispatch(Hydratate(freshState)))
    )
    ->ignore
    None
  }, [])

  (state, dispatch)
}
