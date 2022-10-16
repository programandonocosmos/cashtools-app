let useAuth = () => {
  let (state, dispatch) = Context.AuthContext.use()
  let login = user => dispatch(AuthReducer.Login(user))
  let logout = () => dispatch(AuthReducer.Logout)
  (login, logout, state)
}
