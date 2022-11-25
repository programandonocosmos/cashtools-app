open Utils
open Navigators.MainStack.Navigation
open RescriptNativeBase
module Mutation = %relay(`
  mutation AddAccountMutation($token: String!, $account: NewAccount!) {
    createAccount(token: $token, account: $account) {
      id
      balance
    }
  }
`)

let emptyPreallocated: RelaySchemaAssets_graphql.input_PreAllocationInput = {
  accumulative: None,
  amount: None,
}
let initialState: RelaySchemaAssets_graphql.input_NewAccount = {
  time: 0,
  initialBalance: 0.0,
  name: "",
  description: None,
  preAllocation: Some(emptyPreallocated),
  isAvailable: false,
  earning: None,
}

@react.component
let make = (~navigation, ~route as _) => {
  let (dict, _) = Dict.use()
  let (modalOpen, setModalOpen) = React.useState(() => false)
  let (account, setAccount) = React.useState(() => initialState)
  let onPressNext = _ => {
    navigation->replace("Home")
  }
  let (_, _, maybeUserData) = Hooks.useAuth()
  let (listAccountsRef, _loadQuery, _disposeQuery) = AccountList.Query.useLoader()
  // ~variables={
  //   token: (maybeUserData->UserDomain.getUserDataOrDefault).token,
  //   page: 1,
  //   isPreAllocation: false,
  //   inTrash: false,
  // },
  React.useEffect0(() => {
    try {
      _loadQuery(
        ~variables={
          token: (maybeUserData->UserDomain.getUserDataOrDefault).token,
          page: 1,
          isPreAllocation: false,
          inTrash: false,
        },
        (),
      )
    } catch {
    | _ => Js.log("error")
    }

    None
  })
  let onPressAdd = _ => {
    setModalOpen(_ => true)
  }

  <Box justifyContent="space-between" flex="1" padding="4">
    // {ReactNativePopper.ex}
    <Heading size=#"2xl" color="white"> {"Onde está seu dinheiro?"->s} </Heading>
    <ModalC isOpen={modalOpen} onClose={_ => setModalOpen(_ => false)}>
      <ModalC.Content maxWidth="400px">
        // <ModalC.CloseButton />
        <ModalC.Header> {"Add account"->s} </ModalC.Header>
        <ModalC.Body>
          <VStack flex="1">
            <FormControl.Label> {"Name"->s} </FormControl.Label>
            <Input
            // bg="black"
            // background="black"
              bgColor="muted.900"
              variant=#outline
              value={account.name}
              onChangeText={newName => setAccount(oldAccount => {...oldAccount, name: newName})}
            />
            <FormControl.Label> {"Initial Balance"->s} </FormControl.Label>
            <Input
            // bg="black"
            // background="black"
              bgColor="muted.900"
              variant=#outline
              keyboardType=#numberPad
              value={account.initialBalance->Belt.Float.toString}
              onChangeText={newInitialBalance =>
                setAccount(oldAccount => {
                  ...oldAccount,
                  initialBalance: newInitialBalance
                  ->Belt.Float.fromString
                  ->Belt.Option.getWithDefault(0.0),
                })}
            />
            <HStack>
              <LabeledCheckbox
                onChange={isPrealloc =>
                  setAccount(oldAccount => {
                    ...oldAccount,
                    preAllocation: isPrealloc ? Some(emptyPreallocated) : None,
                  })}
                label="Preallocation?"
              />
              <LabeledCheckbox
                label={"Available?"}
                onChange={availability =>
                  setAccount(oldAccount => {...oldAccount, isAvailable: availability})}
              />
            </HStack>
            <LabeledCheckbox
              label={"Earns?"}
              onChange={willEarn =>
                setAccount(oldAccount => {
                  ...oldAccount,
                  earning: willEarn ? Some({rate: 0., index: #CDI}) : None,
                })}
            />
            {switch account.preAllocation {
            | None => React.null
            | Some(preallocData) =>
              <>
                <FormControl.Label> {"Amount"->s} </FormControl.Label>
                <HStack alignItems="center">
                  <Input
                  // bg="black"
                    keyboardType=#numberPad
                    // background="black"
                    flex="1"
                    bgColor="muted.900"
                    variant=#outline
                    value={preallocData.amount->Belt.Option.getWithDefault(0.)->Belt.Float.toString}
                    onChangeText={newAmount =>
                      setAccount(oldAccount => {
                        ...oldAccount,
                        preAllocation: Some({
                          ...preallocData,
                          amount: Belt.Float.fromString(newAmount),
                        }),
                      })}
                  />
                  <LabeledCheckbox
                    label="Accumulative"
                    onChange={isAcc =>
                      setAccount(oldAccount => {
                        ...oldAccount,
                        preAllocation: Some({
                          ...preallocData,
                          accumulative: Some(isAcc),
                        }),
                      })}
                  />
                </HStack>
              </>
            }}
            {switch account.earning {
            | None => React.null
            | Some(earning) =>
              <>
                <FormControl.Label> {"Rate"->s} </FormControl.Label>
                <SelectMenu
                  flex="0" options={["CDI", "FIXED", "IPCA"]} onPressOption={Js.Console.log}
                />
                <HStack alignItems="center">
                  <Input
                  // bg="black"
                    keyboardType=#numberPad
                    // background="black"
                    flex="1"
                    bgColor="muted.900"
                    variant=#outline
                    value={earning.rate->Belt.Float.toString}
                    onChangeText={newRate =>
                      setAccount(oldAccount => {
                        ...oldAccount,
                        earning: Some({
                          ...earning,
                          rate: Belt.Float.fromString(newRate)->Belt.Option.getWithDefault(0.),
                        }),
                      })}
                  />
                  <Input
                  // bg="black"
                    keyboardType=#numberPad
                    // background="black"
                    flex="1"
                    bgColor="muted.900"
                    variant=#outline
                    value={earning.rate->Belt.Float.toString}
                    onChangeText={newRate =>
                      setAccount(oldAccount => {
                        ...oldAccount,
                        earning: Some({
                          ...earning,
                          rate: Belt.Float.fromString(newRate)->Belt.Option.getWithDefault(0.),
                        }),
                      })}
                  />
                </HStack>
              </>
            }}
          </VStack>
        </ModalC.Body>
        <ModalC.Footer>
          <HStack space={2}>
            <Button
              title=""
              variant="ghost"
              //   colorScheme="blueGray"
              onPress={_ => {
                setModalOpen(_ => false)
              }}>
              {"Cancel"->s}
            </Button>
            <Button
              title=""
              onPress={_ => {
                setModalOpen(_ => false)
              }}>
              {"Save"->s}
            </Button>
          </HStack>
        </ModalC.Footer>
      </ModalC.Content>
    </ModalC>
    // <VStack>
    //   <RescriptReactErrorBoundary
    //     fallback={_ => <Typography> "Error while fetching accounts" </Typography>}>
    //     {switch listAccountsRef {
    //     | Some(listAccountsRef) => <AccountList queryRef=listAccountsRef />
    //     | None => <> </>
    //     }}
    //   </RescriptReactErrorBoundary>
    // </VStack>
    <HStack justifyContent="flex-end">
      <Button title="advance" onPress={onPressAdd}> {dict["add_account"]->s} </Button>
      <Button title="advance" onPress={onPressNext}> {dict["next"]->s} </Button>
    </HStack>
  </Box>
}
