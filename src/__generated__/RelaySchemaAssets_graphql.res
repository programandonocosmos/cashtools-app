/* @generated */
@@ocaml.warning("-30")

@live
type enum_EarningIndex = private [>
  | #CDI
  | #FIXED
  | #IPCA
]

@live
type enum_EarningIndex_input = [
  | #CDI
  | #FIXED
  | #IPCA
]

@live
type enum_RequiredFieldAction = private [>
  | #NONE
  | #LOG
  | #THROW
]

@live
type enum_RequiredFieldAction_input = [
  | #NONE
  | #LOG
  | #THROW
]

@live
type rec input_EarningInput = {
  rate: float,
  index: [#CDI | #FIXED | #IPCA],
}

@live
and input_EarningInput_nullable = {
  rate: float,
  index: [#CDI | #FIXED | #IPCA],
}

@live
and input_NewAccount = {
  time: float,
  initialBalance: float,
  name: string,
  description: option<string>,
  preAllocation: option<input_PreAllocationInput>,
  earning: option<input_EarningInput>,
  isAvailable: bool,
}

@live
and input_NewAccount_nullable = {
  time: float,
  initialBalance: float,
  name: string,
  description?: Js.Null.t<string>,
  preAllocation?: Js.Null.t<input_PreAllocationInput_nullable>,
  earning?: Js.Null.t<input_EarningInput_nullable>,
  isAvailable: bool,
}

@live
and input_NewTransaction = {
  entryDate: string,
  entryAccountCode: option<string>,
  exitAccountCode: option<string>,
  amount: float,
  description: option<string>,
}

@live
and input_NewTransaction_nullable = {
  entryDate: string,
  entryAccountCode?: Js.Null.t<string>,
  exitAccountCode?: Js.Null.t<string>,
  amount: float,
  description?: Js.Null.t<string>,
}

@live
and input_PreAllocationInput = {
  amount: option<float>,
  accumulative: option<bool>,
}

@live
and input_PreAllocationInput_nullable = {
  amount?: Js.Null.t<float>,
  accumulative?: Js.Null.t<bool>,
}

@live
and input_UpdatedAccount = {
  name: option<string>,
  description: option<string>,
  preAllocation: option<input_PreAllocationInput>,
  earning: option<input_EarningInput>,
  isAvailable: option<bool>,
  inTrash: option<bool>,
}

@live
and input_UpdatedAccount_nullable = {
  name?: Js.Null.t<string>,
  description?: Js.Null.t<string>,
  preAllocation?: Js.Null.t<input_PreAllocationInput_nullable>,
  earning?: Js.Null.t<input_EarningInput_nullable>,
  isAvailable?: Js.Null.t<bool>,
  inTrash?: Js.Null.t<bool>,
}
@live @obj
external make_EarningInput: (
  ~rate: float,
  ~index: [#CDI | #FIXED | #IPCA],
) => input_EarningInput = ""

@live @obj
external make_NewAccount: (
  ~time: float,
  ~initialBalance: float,
  ~name: string,
  ~description: string=?,
  ~preAllocation: input_PreAllocationInput=?,
  ~earning: input_EarningInput=?,
  ~isAvailable: bool,
  unit,
) => input_NewAccount = ""

@live @obj
external make_NewTransaction: (
  ~entryDate: string,
  ~entryAccountCode: string=?,
  ~exitAccountCode: string=?,
  ~amount: float,
  ~description: string=?,
  unit,
) => input_NewTransaction = ""

@live @obj
external make_PreAllocationInput: (
  ~amount: float=?,
  ~accumulative: bool=?,
  unit,
) => input_PreAllocationInput = ""

@live @obj
external make_UpdatedAccount: (
  ~name: string=?,
  ~description: string=?,
  ~preAllocation: input_PreAllocationInput=?,
  ~earning: input_EarningInput=?,
  ~isAvailable: bool=?,
  ~inTrash: bool=?,
  unit,
) => input_UpdatedAccount = ""

