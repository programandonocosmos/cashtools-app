@react.component
open ReactNativeSafeAreaContext
let make = _ => {
  let contextVal = AuthReducer.use()

  <ThemeProvider>
    <Context.AuthContext.Provider value=contextVal>
      <SafeAreaProvider>
        <RescriptRelay.Context.Provider environment=RelayEnv.environment>
          <Navigation.RootStackScreen />
        </RescriptRelay.Context.Provider>
      </SafeAreaProvider>
    </Context.AuthContext.Provider>
  </ThemeProvider>
}

let default = make
