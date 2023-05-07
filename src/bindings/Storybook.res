// Adapted from https://github.com/rescriptbr/ancestor/blob/5cb13e050cd50ceba2594787c3ed61d9f1395c5d/core/src/bindings/Ancestor_Storybook.res

let story = (~title, ~component=?, ~argTypes=?, ~excludeStories=[], ()) => {
  let ignoredStories = switch excludeStories {
  | [] => "default"
  | stories => "default|"->Js.String2.concat(stories->Js.Array2.joinWith("|"))
  }

  {
    "title": title,
    "excludeStories": Js.Re.fromString(ignoredStories),
    "component": component,
    "argTypes": argTypes,
  }
}

@module("./storybook.js") external addArgTypes: ('props => React.element, {..}) => unit = "default"
