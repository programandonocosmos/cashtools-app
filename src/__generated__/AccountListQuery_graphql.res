/* @sourceLoc AccountList.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@ocaml.warning("-30")

  type rec response_accounts = {
    @live id: string,
    name: string,
  }
  type response = {
    accounts: array<response_accounts>,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    inTrash: bool,
    isPreAllocation: bool,
    page: int,
    token: string,
  }
  @live
  type refetchVariables = {
    inTrash: option<bool>,
    isPreAllocation: option<bool>,
    page: option<int>,
    token: option<string>,
  }
  @live let makeRefetchVariables = (
    ~inTrash=?,
    ~isPreAllocation=?,
    ~page=?,
    ~token=?,
    ()
  ): refetchVariables => {
    inTrash: inTrash,
    isPreAllocation: isPreAllocation,
    page: page,
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

type queryRef

module Utils = {
  @@ocaml.warning("-33")
  open Types
  @live @obj external makeVariables: (
    ~inTrash: bool,
    ~isPreAllocation: bool,
    ~page: int,
    ~token: string,
  ) => variables = ""


}

type relayOperationNode
type operationType = RescriptRelay.queryNode<relayOperationNode>


let node: operationType = %raw(json` (function(){
var v0 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "inTrash"
},
v1 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "isPreAllocation"
},
v2 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "page"
},
v3 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "token"
},
v4 = [
  {
    "alias": null,
    "args": [
      {
        "kind": "Variable",
        "name": "inTrash",
        "variableName": "inTrash"
      },
      {
        "kind": "Variable",
        "name": "isPreAllocation",
        "variableName": "isPreAllocation"
      },
      {
        "kind": "Variable",
        "name": "page",
        "variableName": "page"
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
        "name": "id",
        "storageKey": null
      },
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "name",
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
      (v1/*: any*/),
      (v2/*: any*/),
      (v3/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "AccountListQuery",
    "selections": (v4/*: any*/),
    "type": "Query",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v3/*: any*/),
      (v2/*: any*/),
      (v1/*: any*/),
      (v0/*: any*/)
    ],
    "kind": "Operation",
    "name": "AccountListQuery",
    "selections": (v4/*: any*/)
  },
  "params": {
    "cacheID": "b5ba0e07ba12cefc273d72c568a40c4a",
    "id": null,
    "metadata": {},
    "name": "AccountListQuery",
    "operationKind": "query",
    "text": "query AccountListQuery(\n  $token: String!\n  $page: Int!\n  $isPreAllocation: Boolean!\n  $inTrash: Boolean!\n) {\n  accounts(token: $token, page: $page, isPreAllocation: $isPreAllocation, inTrash: $inTrash) {\n    id\n    name\n  }\n}\n"
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
