open UserDomain

type authContext = Auth.states

module AuthContext = {
  open React
  let context = createContext((AuthReducer.initialState, AuthReducer.dummyDispatch))

  module Provider = {
    @react.component
    let make = (~value, ~children) => {
      let provider = Context.provider(context)

      createElement(provider, {"value": value, "children": children})
    }
  }
  let use = () => useContext(context)
}
