open RescriptNativeBase
open Theme
open ReactNativeSafeAreaContext

let bgColor = "#181818"
let background = ReactNative.Style.viewStyle(~flex=1., ~backgroundColor=bgColor, ())

open Js.Dict
let base = {
  components: {
    \"Button": {
      baseStyle: _ => {
        alignSelf: "center",
        padding: "16px",
      },
      defaultProps: fromArray([("size", "md")]),
      variants: fromArray([
        (
          "container",
          _ => {
            padding: "16",
          },
        ),
      ]),
    },
    \"Box": {
      variants: fromArray([
        (
          "container",
          _ => {
            padding: "4",
            background: "#171717",
            flex: "1",
          },
        ),
      ]),
    },
    \"VStack": {
      defaultProps: fromArray([("spacing", "2"), ("padding", "2")]),
    },
    \"Heading": {
      baseStyle: _ => {
        color: "text.100",
        fontWeight: "medium",
      },
      sizes: fromArray([
        (
          "2xl",
          _ => {
            fontSize: "60px",
          },
        ),
      ]),
    },
    \"Text": {
      baseStyle: _ => {
        color: "text.100",
        fontWeight: "medium",
      },
    },
    \"Input": {
      defaultProps: fromArray([
        ("variant", "filled"),
        ("size", "2xl"),
        ("backgroundColor", "muted.800"),
        ("borderColor", "muted.800"),
        ("padding", "2"),
        ("color", "white"),
      ]),
    },
  },
}

@react.component
let make = (~children) => {
  let customTheme = extendTheme(base)
  <NativeBaseProvider theme=customTheme>
    <SafeAreaView style=background> children </SafeAreaView>
  </NativeBaseProvider>
}
