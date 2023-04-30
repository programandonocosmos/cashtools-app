/* @sourceLoc TransactionList.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@ocaml.warning("-30")

  type rec response_transactions = {
    amount: float,
    description: option<string>,
    entryAccountCode: option<string>,
    entryDate: string,
  }
  type response = {
    transactions: array<response_transactions>,
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
    json`{"__root":{"transactions_entryDate":{"b":""},"transactions_entryAccountCode":{"b":""},"transactions_amount":{"b":""}}}`
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
    json`{"__root":{"transactions_entryDate":{"b":""},"transactions_entryAccountCode":{"b":""},"transactions_amount":{"b":""}}}`
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
        "kind": "Variable",
        "name": "token",
        "variableName": "token"
      }
    ],
    "concreteType": "Transaction",
    "kind": "LinkedField",
    "name": "transactions",
    "plural": true,
    "selections": [
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "amount",
        "storageKey": null
      },
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "entryDate",
        "storageKey": null
      },
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "entryAccountCode",
        "storageKey": null
      },
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "description",
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
    "name": "TransactionListQuery",
    "selections": (v1/*: any*/),
    "type": "Query",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "TransactionListQuery",
    "selections": (v1/*: any*/)
  },
  "params": {
    "cacheID": "049c06d90c8cbdb0051d784dd363c357",
    "id": null,
    "metadata": {},
    "name": "TransactionListQuery",
    "operationKind": "query",
    "text": "query TransactionListQuery(\n  $token: String!\n) {\n  transactions(token: $token) {\n    amount\n    entryDate\n    entryAccountCode\n    description\n  }\n}\n"
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
