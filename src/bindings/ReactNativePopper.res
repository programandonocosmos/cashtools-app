// <Popover
//   on="press"
//   placement="bottom"
//   trigger={
//     <Button>
//       <Text>Press me</Text>
//     </Button>
//   }

//   shouldCloseOnOutsideClick={true}
// >

//   <Popover.Content>
//     <Text>Hello from popover</Text>
//   </Popover.Content>
// </Popover>
module Popover = {
  // Module contents
  @react.component @module("react-native-popper")
  external make: (
    ~children: React.element=?,
    ~on: [#press | #hover | #longPress]=?,
    ~placement: [#bottom | #top | #left | #right]=?,
    ~trigger: React.element=?,
    ~shouldCloseOnOutsideClick: bool=?,
    ~isOpen: bool=?,
    ~onOpenChange: bool => unit=?,
  ) => React.element = "Popover"

  module Content = {
    @react.component @module("react-native-popper") @scope("Popover")
    external make: (~children: React.element=?) => React.element = "Content"
  }
  module Backdrop = {
    @react.component @module("react-native-popper") @scope("Popover")
    external make: (~children: React.element=?) => React.element = "Backdrop"
    module Arrow = {
      @react.component @module("react-native-popper") @scope("Popover")
      external make: (~children: React.element=?) => React.element = "Arrow"
    }
  }
  module Tooltip = {
    // Module contents
    @react.component @module("react-native-popper")
    external make: (
      ~children: React.element=?,
      ~on: [#press | #hover | #longPress]=?,
      ~placement: [#bottom | #top | #left | #right]=?,
      ~trigger: React.element=?,
      ~shouldCloseOnOutsideClick: bool=?,
      ~isOpen: bool=?,
      ~onOpenChange: bool => unit=?,
    ) => React.element = "Tooltip"

    module Content = {
      @react.component @module("react-native-popper") @scope("Tooltip")
      external make: (~children: React.element=?) => React.element = "Content"
    }
    module Backdrop = {
      @react.component @module("react-native-popper") @scope("Tooltip")
      external make: (~children: React.element=?) => React.element = "Backdrop"
      module Arrow = {
        @react.component @module("react-native-popper") @scope("Tooltip")
        external make: (~children: React.element=?) => React.element = "Arrow"
      }
    }
  }
}

let ex =
  <Popover
    on=#press
    placement=#bottom
    trigger={<RescriptNativeBase.Button title="" onPress={Js.Console.log}>
      <Typography> "Hey" </Typography>
    </RescriptNativeBase.Button>}
    shouldCloseOnOutsideClick={true}>
    <Popover.Content>
      <Typography> "Hey" </Typography>
    </Popover.Content>
  </Popover>
