type userInfo = {username: string, name: string, token: string}
type authStates = LoggedIn(userInfo) | LoggedOut

let dummyUser = {
  username: "dummy",
  name: "Dummy User",
  token: "sas",
}
