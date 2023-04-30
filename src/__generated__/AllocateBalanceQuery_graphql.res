/* @sourceLoc AllocateBalance.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@ocaml.warning("-30")

  type rec response_accounts_preAllocation = {
    amount: float,
  }
  and response_accounts = {
    balance: float,
    description: option<string>,
    name: string,
    preAllocation: option<response_accounts_preAllocation>,
  }
  type response = {
    accounts: array<response_accounts>,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    token: string,
  }
  @live
  type refetchVariables = {
    token: option<string>,
  }
  @live let makeRefetchVariables = (
    ~token=?,
    ()
  ): refetchVariables => {
    token: token
  }

}

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{}`
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
    json`{"__root":{"accounts_preAllocation_amount":{"b":""},"accounts_balance":{"b":""}}}`
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
    json`{"__root":{"accounts_preAllocation_amount":{"b":""},"accounts_balance":{"b":""}}}`
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

type queryRef

module Utils = {
  @@ocaml.warning("-33")
  open Types
  @live @obj external makeVariables: (
    ~token: string,
  ) => variables = ""


}

type relayOperationNode
type operationType = RescriptRelay.queryNode<relayOperationNode>


let node: operationType = %raw(json` (function(){
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "token"
  }
],
v1 = [
  {
    "alias": null,
    "args": [
      {
        "kind": "Literal",
        "name": "inTrash",
        "value": false
      },
      {
        "kind": "Literal",
        "name": "isPreAllocation",
        "value": true
      },
      {
        "kind": "Variable",
        "name": "token",
        "variableName": "token"
      }
    ],
    "concreteType": "Account",
    "kind": "LinkedField",
    "name": "accounts",
    "plural": true,
    "selections": [
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "description",
        "storageKey": null
      },
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "name",
        "storageKey": null
      },
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "balance",
        "storageKey": null
      },
      {
        "alias": null,
        "args": null,
        "concreteType": "PreAllocation",
        "kind": "LinkedField",
        "name": "preAllocation",
        "plural": false,
        "selections": [
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "amount",
            "storageKey": null
          }
        ],
        "storageKey": null
      }
    ],
    "storageKey": null
  }
];
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "AllocateBalanceQuery",
    "selections": (v1/*: any*/),
    "type": "Query",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "AllocateBalanceQuery",
    "selections": (v1/*: any*/)
  },
  "params": {
    "cacheID": "0ed5888921ef3fd59020ea754006b061",
    "id": null,
    "metadata": {},
    "name": "AllocateBalanceQuery",
    "operationKind": "query",
    "text": "query AllocateBalanceQuery(\n  $token: String!\n) {\n  accounts(token: $token, isPreAllocation: true, inTrash: false) {\n    description\n    name\n    balance\n    preAllocation {\n      amount\n    }\n  }\n}\n"
  }
};
})() `)

include RescriptRelay.MakeLoadQuery({
    type variables = Types.variables
    type loadedQueryRef = queryRef
    type response = Types.response
    type node = relayOperationNode
    let query = node
    let convertVariables = Internal.convertVariables
});
