open RescriptNativeBase

open Belt
module Day = {
  @react.component
  let make = (~value: option<int>, ~onPress: option<int> => unit, ~selected: bool) => {
    if value === Some(0) {
      <Box width="42px" />
    } else {
      <Button
        variant=""
        title={"day"}
        width="42px"
        // borderColor="white"
        background={selected ? "muted.600" : "muted.800"}
        // borderWidth="1"
        onPress={_ => onPress(value)}>
        <Typography> {value->Option.map(Belt.Int.toString)->Option.getWithDefault("")} </Typography>
      </Button>
    }
  }
  let make = React.memo(make)
}
let month = [
  Array.range(0, 6),
  Array.range(7, 13),
  Array.range(14, 20),
  Array.range(21, 27),
  Array.range(28, 31),
]
@react.component
let make = (~selected: option<int>, ~onChange: option<int> => unit) => {
  <Box>
    <VStack space=1>
      {month
      ->Array.map(days =>
        <HStack space=1>
          {days
          ->Array.map(day =>
            <Day
              value=Some(day)
              key={Belt.Int.toString(day)}
              selected={Some(day) == selected}
              onPress={_ => onChange(Some(day))}
            />
          )
          ->React.array}
        </HStack>
      )
      ->React.array}
    </VStack>
  </Box>
}
