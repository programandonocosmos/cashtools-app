@react.component
module AccountListItem = %relay(`
  fragment AccountList_item on Account {
    id
    name
  }
`)
module Query = %relay(`
  query AccountListQuery($token: String!, $inTrash: Boolean!) {
    __id
    accounts(token: $token, inTrash: $inTrash) {
      ...AccountList_item
    }
  }
`)
open AccountListQuery_graphql.Types
module AccountItem = {
  @react.component
  let make = (~account) => {
    let account = AccountListItem.use(account)
    <Box
      bg="muted.800"
      borderRadius="8"
      paddingBottom="4"
      paddingTop="4"
      paddingLeft="8"
      paddingRight="8">
      <Typography fontSize="32" key=account.id> {account.name} </Typography>
    </Box>
  }
}

@react.component
let make = (~queryRef) => {
  let data = Query.usePreloaded(~queryRef, ())
  let (dict, _) = Dict.use()
  <VStack>
    <ReactNative.FlatList
      \"ItemSeparatorComponent"={_ => <Box height="2" />}
      data=data.accounts
      keyExtractor={(_, i) => Belt.Int.toString(i)}
      renderItem={({item: account}) => <AccountItem account={account.fragmentRefs} />}
    />
    {Array.length(data.accounts) == 0
      ? <Box>
          <Heading size=#lg> {dict["no_accounts_yet"]->React.string} </Heading>
        </Box>
      : React.null}
  </VStack>
}
