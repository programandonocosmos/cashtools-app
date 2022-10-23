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

module DictinaryContext = {
  open React

  let dict = {
    "en": {
      "login": "Login",
      "name": "Name",
      "next": "Next",
      "loading": "Loading...",
      "sign_in": "Sign in",
      "sign_up": "Sign up",
      "create_an_account": "Create an account",
      "enter_code_email": "Enter the code we sent to your email",
      "back": "Back",
      "create_account": "Create account",
    },
    "br": {
      "login": "Login",
      "name": "Name",
      "next": "Next",
      "loading": "Loading...",
      "sign_in": "Sign in",
      "sign_up": "Sign up",
      "create_an_account": "Create an account",
      "enter_code_email": "Envie o código que enviamos para o seu e-mail",
      "back": "Voltar",
      "create_account": "Criar conta",
    },
  }

  type availableLanguages = En | Br

  let useLocalDict = () => {
    let (translations, setTranslations) = React.useState(() => dict["br"])

    let setLanguage = lang => {
      switch lang {
      | En => setTranslations(_ => dict["en"])
      | Br => setTranslations(_ => dict["br"])
      }
    }

    (translations, setLanguage)
  }

  let context = createContext((dict["br"], _ => ()))

  module Provider = {
    @react.component
    let make = (~children) => {
      let provider = Context.provider(context)
      let value = useLocalDict()
      createElement(provider, {"value": value, "children": children})
    }
  }
  let use = () => useContext(context)
}
