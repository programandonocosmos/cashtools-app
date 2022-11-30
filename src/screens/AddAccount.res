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
open RelaySchemaAssets_graphql
let emptyPreallocated: input_PreAllocationInput = {
  accumulative: None,
  amount: None,
}
let initialState: input_NewAccount = {
  time: Js.Date.now()->Belt.Float.toInt,
  initialBalance: 0.0,
  name: "",
  description: None,
  preAllocation: None,
  isAvailable: false,
  earning: None,
}
let trace = s => {
  Js.Console.log(s)
  s
}

let round = (~decimal=2, num) => {
  let magicNumber = Js.Math.pow_float(~base=10., ~exp=Belt.Float.fromInt(decimal))
  Js.Math.round(num *. magicNumber) /. magicNumber
}

// let getAmountOfDecimals = source => {
//   source->Belt.
// }

module Percentage = {
  type t = float
  let ofString = src =>
    src
    ->trace
    ->Js.String2.replace("%", "")
    ->trace
    ->Belt.Float.fromString
    ->Belt.Option.getWithDefault(0.)
  let toString = num => {
    `${num->round->Belt.Float.toString}%`
  }
  let getPosition = num => num->toString->String.length - 1
}

let monthlyToAnnualRate = rate =>
  (Js.Math.pow_float(~base=1. +. rate /. 100., ~exp=12.) -. 1.) *. 100.
let annualToMonthlyRate = rate =>
  (Js.Math.pow_float(~base=1. +. rate /. 100., ~exp=1. /. 12.) -. 1.) *. 100.
let emptyEarn = {
  rate: 0.,
  index: #FIXED,
}

module Form = {
  @react.component
  let make = (
    ~account: input_NewAccount,
    ~setAccount: (input_NewAccount => input_NewAccount) => unit,
  ) => {
    // let account = form.values.value
    let (mutate, isMutating) = Mutation.use()
    let (dict, _) = Dict.use()

    let onChangeAvailability = availability =>
      setAccount(oldAccount => {...oldAccount, isAvailable: availability})
    let onChangeName = newName => setAccount(oldAccount => {...oldAccount, name: newName})
    let onChangeInitialBalance = newInitialBalance =>
      setAccount(oldAccount => {
        ...oldAccount,
        initialBalance: newInitialBalance->Belt.Float.fromString->Belt.Option.getWithDefault(0.0),
      })
    let onChangePrealloc = isPrealloc =>
      setAccount(oldAccount => {
        ...oldAccount,
        preAllocation: isPrealloc ? Some(emptyPreallocated) : None,
      })
    let onChangeIsEarn = willEarn =>
      setAccount(oldAccount => {
        ...oldAccount,
        earning: willEarn ? Some({rate: 0., index: #CDI}) : None,
      })
    let onChangeAmount = newAmount =>
      setAccount(oldAccount => {
        ...oldAccount,
        preAllocation: Some({
          ...oldAccount.preAllocation->Belt.Option.getWithDefault(emptyPreallocated),
          amount: Belt.Float.fromString(newAmount),
        }),
      })
    let onChangIsAcc = isAcc =>
      setAccount(oldAccount => {
        ...oldAccount,
        preAllocation: Some({
          ...oldAccount.preAllocation->Belt.Option.getWithDefault(emptyPreallocated),
          accumulative: Some(isAcc),
        }),
      })
    let onChangeMonthlyRate = newRate =>
      setAccount(oldAccount => {
        ...oldAccount,
        earning: Some({
          ...oldAccount.earning->Belt.Option.getWithDefault(emptyEarn),
          rate: newRate->Percentage.ofString,
        }),
      })
    let onChangeYearlyRate = newRate =>
      setAccount(oldAccount => {
        ...oldAccount,
        earning: Some({
          ...oldAccount.earning->Belt.Option.getWithDefault(emptyEarn),
          rate: newRate->Percentage.ofString->annualToMonthlyRate,
        }),
      })

    <VStack flex="1">
      <FormControl.Label> {"Name"->s} </FormControl.Label>
      <Input
      // bg="black"
      // background="black"
        bgColor="muted.900" variant=#outline value={account.name} onChangeText={onChangeName}
      />
      <FormControl.Label> {"Initial Balance"->s} </FormControl.Label>
      <Input
      // bg="black"
      // background="black"
        bgColor="muted.900"
        variant=#outline
        keyboardType=#numberPad
        value={account.initialBalance->Belt.Float.toString}
        onChangeText={onChangeInitialBalance}
      />
      <HStack>
        <LabeledCheckbox onChange={onChangePrealloc} label="Preallocation?" />
        <LabeledCheckbox label={"Available?"} onChange={onChangeAvailability} />
      </HStack>
      <LabeledCheckbox label={"Earns?"} onChange={onChangeIsEarn} />
      {switch account.preAllocation {
      | None => React.null
      | Some(preallocData) =>
        <>
          <FormControl.Label> {dict["amount"]->s} </FormControl.Label>
          <HStack alignItems="center">
            <Input
            // bg="black"
              keyboardType=#numberPad
              // background="black"
              flex="1"
              bgColor="muted.900"
              variant=#outline
              value={preallocData.amount->Belt.Option.getWithDefault(0.)->Belt.Float.toString}
              onChangeText={onChangeAmount}
            />
            <LabeledCheckbox label={dict["accumulative"]} onChange={onChangIsAcc} />
          </HStack>
        </>
      }}
      {switch account.earning {
      | None => React.null
      | Some(earning) =>
        <>
          <FormControl.Label> {"Rate"->s} </FormControl.Label>
          <SelectMenu flex="0" options={["CDI", "FIXED", "IPCA"]} onPressOption={Js.Console.log} />
          <HStack flex="1" alignItems="flex-start">
            <VStack flex="1">
              <FormControl.Label> {"a.m."->s} </FormControl.Label>
              <Input
              // bg="black"
                keyboardType=#numberPad
                // background="black"

                bgColor="muted.900"
                selection={
                  start: Percentage.getPosition(earning.rate),
                  end: Percentage.getPosition(earning.rate),
                }
                variant=#outline
                value={earning.rate->Percentage.toString}
                onChangeText={onChangeMonthlyRate}
              />
            </VStack>
            <VStack flex="1">
              <FormControl.Label> {"a.a."->s} </FormControl.Label>
              <Input
              // bg="black"
                keyboardType=#numberPad
                // background="black"

                bgColor="muted.900"
                selection={
                  start: Percentage.getPosition(earning.rate->monthlyToAnnualRate),
                  end: Percentage.getPosition(earning.rate->monthlyToAnnualRate),
                }
                variant=#outline
                value={earning.rate->monthlyToAnnualRate->Percentage.toString}
                onChangeText={onChangeYearlyRate}
              />
            </VStack>
          </HStack>
        </>
      }}
    </VStack>
  }
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
  let (listAccountsRef, loadQuery, _disposeQuery) = AccountList.Query.useLoader()
  let (mutate, isMutating) = Mutation.use()
  // ~variables={
  //   token: (maybeUserData->UserDomain.getUserDataOrDefault).token,
  //   page: 1,
  //   isPreAllocation: false,
  //   inTrash: false,
  // },
  let token = (maybeUserData->UserDomain.getUserDataOrDefault).token
  Js.Console.log(token)

  React.useEffect0(() => {
    try {
      loadQuery(
        ~variables={
          token,
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
  let onPressSave = _ => {
    setModalOpen(_ => false)
    mutate(
      ~variables={account, token},
      ~onError=Js.Console.log,
      ~onCompleted=(_, _) => (),
      (),
    )->ignore
  }
  <Box justifyContent="space-between" flex="1" padding="4">
    // {ReactNativePopper.ex}
    <Heading size=#"2xl" color="white"> {dict["where_money"]->s} </Heading>
    <Form account setAccount />
    <ModalC avoidKeyboard=true isOpen={modalOpen} onClose={_ => setModalOpen(_ => false)}>
      <ModalC.Content maxWidth="400px">
        // <ModalC.CloseButton />
        <ModalC.Header> {"Add account"->s} </ModalC.Header>
        <ModalC.Body>
          <Form account setAccount />
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
            <Button title="" onPress={onPressSave}> {"Save"->s} </Button>
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
      <Button title="advance" onPress={onPressNext}>
        {(isMutating ? "..." : dict["next"])->s}
      </Button>
    </HStack>
  </Box>
}
