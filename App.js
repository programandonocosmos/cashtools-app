import { extendTheme, NativeBaseProvider } from "native-base";
import Routes from "./src/App.bs";
const App = () => {
  const theme = extendTheme({
    useSystemColorMode: false,
    initialColorMode: "dark",
  });
  return (
    <NativeBaseProvider theme={theme}>
      <Routes />
    </NativeBaseProvider>
  );
};
export default App;
