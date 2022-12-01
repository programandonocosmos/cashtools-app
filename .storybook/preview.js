import { make as ThemeProvider } from "../src/theme/ThemeProvider.bs";

export const decorators = [
  (Story) => (
    <ThemeProvider>
      <Story />
    </ThemeProvider>
  ),
];
export const parameters = {};
