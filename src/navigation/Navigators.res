open ReactNavigation

module MainStack = {
  module M = {
    type params = {email: string, username: string, name: string}
  }
  include NativeStack.Make(M)
}

module M = {
  type params = unit
}

module RootStack = NativeStack.Make(M)
