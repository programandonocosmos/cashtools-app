type userInfo = {username: string, name: string, id: string}
type authStates = LoggedIn(userInfo) | LoggedOut

let dummyUser = {
  username: "dummy",
  name: "Dummy User",
  id: "123",
}
