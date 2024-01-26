@react.component
let make = (~children=React.null, ~label="", ~onChange=?, ~value=?) => {
  <HStack>
    <Checkbox accessibilityLabel=label ?onChange ?value />
    <Typography> {label} </Typography>
    {children}
  </HStack>
}
