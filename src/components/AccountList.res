@react.component
module Query = %relay(`
  query AccountListQuery(
    $token: String!
    $page: Int!
    $isPreAllocation: Boolean!
    $inTrash: Boolean!
  ) {
    accounts(
      token: $token
      page: $page
      isPreAllocation: $isPreAllocation
      inTrash: $inTrash
    ) {
      id
      name
    }
  }
`)
open AccountListQuery_graphql.Types
@react.component
let make = (~queryRef) => {
  let data = Query.usePreloaded(~queryRef, ())

  <VStack>
    {data.accounts
    |> Array.map(account => <Typography key=account.id> {account.name} </Typography>)
    |> React.array}
  </VStack>
}
