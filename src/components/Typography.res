open Belt

let make = Text.make
let makeProps = (~children: option<string>=?) =>
  Text.makeProps(~children=children->Option.getWithDefault("")->React.string)
