type userInfo = {username: string, name: string, token: string}

let dummyUser = {
  username: "dummy",
  name: "Dummy User",
  token: "sas",
}
module Auth = {
  type states = LoggedIn(userInfo) | LoggedOut
}
let getUserDataOrDefault = (user: Auth.states) => {
  switch user {
  | LoggedIn(user) => user
  | LoggedOut => dummyUser
  }
}
