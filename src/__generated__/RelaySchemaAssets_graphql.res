/* @generated */
@@ocaml.warning("-30")

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
type rec input_NewTransaction = {
  entryDate: string,
  entryAccountCode: option<string>,
  exitAccountCode: option<string>,
  amount: float,
  description: option<string>,
}
@live @obj
external make_NewTransaction: (
  ~entryDate: string,
  ~entryAccountCode: string=?,
  ~exitAccountCode: string=?,
  ~amount: float,
  ~description: string=?,
  unit,
) => input_NewTransaction = ""

