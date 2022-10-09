open UserDomain

type action = Login(userInfo) | Logout

let initialState = LoggedOut
let dummyDispatch = (_: action) => ()
let reducer = (_state, action) => {
  switch action {
  | Login(user) => LoggedIn(user)
  | Logout => LoggedOut
  }
}
