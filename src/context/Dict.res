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
    "already_have_account": "Already have an account?",
    "username_length_error": "Username must be at least 3 characters long",
    "username": "Username",
    "add_account": "Add account",
  },
  "br": {
    "login": "Login",
    "name": "Name",
    "next": "Avançar",
    "loading": "...",
    "sign_in": "Entrar",
    "sign_up": "Cadastre=se",
    "create_an_account": "Criar uma conta",
    "enter_code_email": "Envie o código que enviamos para o seu e-mail",
    "back": "Voltar",
    "create_account": "Criar conta",
    "already_have_account": "Já tem uma conta?",
    "username_length_error": "O nome de usuário deve ter pelo menos 3 caracteres",
    "username": "Nome de usuário",
    "add_account": "Adicionar conta",
  },
}

module Context = {
  open React

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
}

let use = () => React.useContext(Context.context)
