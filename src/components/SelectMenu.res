open Belt
open Reanimated

@react.component
let make = (
  ~children=<> </>,
  ~options,
  ~onPressOption,
  ~placeholder="Select an option",
  ~preSelected=None,
  ~value=?,
  ~flex="1",
) => {
  let (selectedState, setSelected) = React.useState(() => preSelected)
  let (isOpen, setIsOpen) = React.useState(() => false)
  let selected = Option.isSome(value) ? value : selectedState
  let hideOptions = () => setIsOpen(_ => false)
  let showOptions = () => setIsOpen(_ => true)
  let toggle = () => {
    isOpen ? hideOptions() : showOptions()
  }

  let select = option => {
    setSelected(_ => option)
    hideOptions()
    onPressOption(_ => option)
  }

  let exitKeyframe = KeyFrame.keyframe({
    from: reanimatedStyle(~transform=[ReanimatedStyle.translateY(~translateY=0.)], ~opacity=1., ()),
    to: reanimatedStyle(~transform=[ReanimatedStyle.translateY(~translateY=-60.)], ~opacity=0., ()),
  })->duration(50.)

  let widthRef = React.useRef(10.)

  <Box
    // zIndex="10"
    background="muted.800"
    borderRadius="4px"
    variant="dropdown"
    flex
    alignSelf="stretch">
    <ReactNativePopper.Popover
      isOpen
      trigger={<ReactNative.View
        onLayout={e => {
          widthRef.current = e.nativeEvent.layout.width
          ()
        }}>
        <Button
          height="50px"
          width="100%"
          background="muted.800"
          justifyContent="space-between"
          flexDirection="row"
          variant="unstyled"
          onPress={_ => toggle()}
          // zIndex="1"
          title="options">
          <Box
            flexDirection="row"
            flex="1"
            minWidth="100%"
            maxWidth="100%"
            alignItems="center"
            justifyContent="space-between">
            <Typography
              background="#000"
              color={!Option.isSome(selected) ? "text.600" : "text.50"}
              fontSize="20px">
              {selected->Option.getWithDefault(placeholder)}
            </Typography>
            <Icon.MaterialCommunityIcons name="chevron-down" size=32 color="white" />
          </Box>
        </Button>
      </ReactNative.View>}>
      <ReactNativePopper.Popover.Backdrop />
      <ReactNativePopper.Popover.Content>
        <Reanimated.View exiting={exitKeyframe} entering={fadeInUp->duration(100.)}>
          <Box
            marginTop="4px"
            background="muted.800"
            borderRadius="4px"
            // flex="1"
            zIndex="10"
            width={widthRef.current->Float.toString}
            alignSelf="stretch"
            // position="absolute"
            variant="dropdown__options">
            <Button
              width="100%"
              justifyContent="flex-start"
              height="50px"
              title="option"
              variant="dropdown__option"
              onPress={_ => select(None)}>
              <HStack alignItems="center">
                <Icon.MaterialCommunityIcons
                  size=20 color={Option.isNone(selected) ? "white" : "#262626"} name="check"
                />
                <Typography> {placeholder} </Typography>
              </HStack>
            </Button>
            {options
            ->Belt.Array.map(option =>
              <Button
                width="100%"
                justifyContent="flex-start"
                height="50px"
                title="option"
                variant="dropdown__option"
                onPress={_ => select(Some(option))}>
                <HStack alignItems="center">
                  <Icon.MaterialCommunityIcons
                    name="check"
                    size=20
                    color={Option.getWithDefault(selected, "") == option ? "white" : "#262626"}
                  />
                  <Typography> {option} </Typography>
                </HStack>
              </Button>
            )
            ->React.array}
          </Box>
        </Reanimated.View>
      </ReactNativePopper.Popover.Content>
    </ReactNativePopper.Popover>
    // {isOpen
    //   ?
    //   : React.null}
    children
  </Box>
}
