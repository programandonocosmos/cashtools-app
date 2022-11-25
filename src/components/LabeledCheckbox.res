@react.component
let make = (~children=React.null, ~label="", ~onChange=?) => {
  <HStack>
    <Checkbox accessibilityLabel=label ?onChange />
    <Typography> {label} </Typography>
    {children}
  </HStack>
}
