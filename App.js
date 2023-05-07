import StorybookUIRoot from "./.storybook/Storybook";
import Routes from "./src/App.bs";
import { env } from "./src/Env.bs";
const App = () => {
  return env.storybookMode ? <StorybookUIRoot /> : <Routes />;
};
export default App;
