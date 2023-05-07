import { getStorybookUI } from "@storybook/react-native";
console.log("rendering storybook...");

import "./storybook.requires";
const StorybookUIRoot = getStorybookUI({});

export default StorybookUIRoot;
