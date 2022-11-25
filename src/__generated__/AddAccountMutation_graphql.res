/* @sourceLoc AddAccount.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@ocaml.warning("-30")

  @live type newAccount = RelaySchemaAssets_graphql.input_NewAccount
  @live type preAllocationInput = RelaySchemaAssets_graphql.input_PreAllocationInput
  @live type earningInput = RelaySchemaAssets_graphql.input_EarningInput
  @live
  type rec response_createAccount = {
    balance: float,
    @live id: string,
  }
  @live
  type response = {
    createAccount: response_createAccount,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    account: newAccount,
    token: string,
  }
}

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"earningInput":{},"preAllocationInput":{},"newAccount":{"preAllocation":{"r":"preAllocationInput"},"earning":{"r":"earningInput"}},"__root":{"account":{"r":"newAccount"}}}`
  )
  @live
  let variablesConverterMap = ()
  @live
  let convertVariables = v => v->RescriptRelay.convertObj(
    variablesConverter,
    variablesConverterMap,
    Js.undefined
  )
  @live
  type wrapResponseRaw
  @live
  let wrapResponseConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{}`
  )
  @live
  let wrapResponseConverterMap = ()
  @live
  let convertWrapResponse = v => v->RescriptRelay.convertObj(
    wrapResponseConverter,
    wrapResponseConverterMap,
    Js.null
  )
  @live
  type responseRaw
  @live
  let responseConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{}`
  )
  @live
  let responseConverterMap = ()
  @live
  let convertResponse = v => v->RescriptRelay.convertObj(
    responseConverter,
    responseConverterMap,
    Js.undefined
  )
  type wrapRawResponseRaw = wrapResponseRaw
  @live
  let convertWrapRawResponse = convertWrapResponse
  type rawResponseRaw = responseRaw
  @live
  let convertRawResponse = convertResponse
}
module Utils = {
  @@ocaml.warning("-33")
  open Types
  @live
  external earningIndex_toString: RelaySchemaAssets_graphql.enum_EarningIndex => string = "%identity"
  @live
  external earningIndex_input_toString: RelaySchemaAssets_graphql.enum_EarningIndex_input => string = "%identity"
  @live
  let earningIndex_decode = (enum: RelaySchemaAssets_graphql.enum_EarningIndex): option<RelaySchemaAssets_graphql.enum_EarningIndex_input> => {
    switch enum {
      | #...RelaySchemaAssets_graphql.enum_EarningIndex_input as valid => Some(valid)
      | _ => None
    }
  }
  @live
  let earningIndex_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_EarningIndex_input> => {
    earningIndex_decode(Obj.magic(str))
  }
  @live @obj external make_newAccount: (
    ~description: string=?,
    ~earning: earningInput=?,
    ~initialBalance: float,
    ~isAvailable: bool,
    ~name: string,
    ~preAllocation: preAllocationInput=?,
    ~time: int,
    unit
  ) => newAccount = ""


  @live @obj external make_preAllocationInput: (
    ~accumulative: bool=?,
    ~amount: float=?,
    unit
  ) => preAllocationInput = ""


  @live @obj external make_earningInput: (
    ~index: [
      | #CDI
      | #FIXED
      | #IPCA
    ],
    ~rate: float,
  ) => earningInput = ""


  @live @obj external makeVariables: (
    ~account: newAccount,
    ~token: string,
  ) => variables = ""


}

type relayOperationNode
type operationType = RescriptRelay.mutationNode<relayOperationNode>


let node: operationType = %raw(json` (function(){
var v0 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "account"
},
v1 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "token"
},
v2 = [
  {
    "alias": null,
    "args": [
      {
        "kind": "Variable",
        "name": "account",
        "variableName": "account"
      },
      {
        "kind": "Variable",
        "name": "token",
        "variableName": "token"
      }
    ],
    "concreteType": "Account",
    "kind": "LinkedField",
    "name": "createAccount",
    "plural": false,
    "selections": [
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "id",
        "storageKey": null
      },
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "balance",
        "storageKey": null
      }
    ],
    "storageKey": null
  }
];
return {
  "fragment": {
    "argumentDefinitions": [
      (v0/*: any*/),
      (v1/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "AddAccountMutation",
    "selections": (v2/*: any*/),
    "type": "Mutations",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v1/*: any*/),
      (v0/*: any*/)
    ],
    "kind": "Operation",
    "name": "AddAccountMutation",
    "selections": (v2/*: any*/)
  },
  "params": {
    "cacheID": "25e6f5958b4b2ad1d9a6e2b25e06c67a",
    "id": null,
    "metadata": {},
    "name": "AddAccountMutation",
    "operationKind": "mutation",
    "text": "mutation AddAccountMutation(\n  $token: String!\n  $account: NewAccount!\n) {\n  createAccount(token: $token, account: $account) {\n    id\n    balance\n  }\n}\n"
  }
};
})() `)


