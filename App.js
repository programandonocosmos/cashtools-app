import { env } from "./src/Env.bs";
import Routes from "./src/App.bs";
// import StorybookUIRoot from "./.storybook/Storybook";
const App = () => {
  // return env.storybookMode ? <StorybookUIRoot /> : <Routes />;
  return <Routes />;
};
export default App;
