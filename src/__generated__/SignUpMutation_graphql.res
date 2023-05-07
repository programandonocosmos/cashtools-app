/* @sourceLoc SignUp.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@ocaml.warning("-30")

  @live
  type rec response_createUser = {@live id: string}
  @live
  type response = {createUser: response_createUser}
  @live
  type rawResponse = response
  @live
  type variables = {
    email: string,
    name: string,
    username: string,
  }
}

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(json`{}`)
  @live
  let variablesConverterMap = ()
  @live
  let convertVariables = v =>
    v->RescriptRelay.convertObj(variablesConverter, variablesConverterMap, Js.undefined)
  @live
  type wrapResponseRaw
  @live
  let wrapResponseConverter: Js.Dict.t<
    Js.Dict.t<Js.Dict.t<string>>,
  > = %raw(json`{"__root":{"createUser_id":{"b":""}}}`)
  @live
  let wrapResponseConverterMap = ()
  @live
  let convertWrapResponse = v =>
    v->RescriptRelay.convertObj(wrapResponseConverter, wrapResponseConverterMap, Js.null)
  @live
  type responseRaw
  @live
  let responseConverter: Js.Dict.t<
    Js.Dict.t<Js.Dict.t<string>>,
  > = %raw(json`{"__root":{"createUser_id":{"b":""}}}`)
  @live
  let responseConverterMap = ()
  @live
  let convertResponse = v =>
    v->RescriptRelay.convertObj(responseConverter, responseConverterMap, Js.undefined)
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
  @live @obj
  external makeVariables: (~email: string, ~name: string, ~username: string) => variables = ""
}

type relayOperationNode
type operationType = RescriptRelay.mutationNode<relayOperationNode>

let node: operationType = %raw(json` (function(){
var v0 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "email"
},
v1 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "name"
},
v2 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "username"
},
v3 = [
  {
    "alias": null,
    "args": [
      {
        "kind": "Variable",
        "name": "email",
        "variableName": "email"
      },
      {
        "kind": "Variable",
        "name": "name",
        "variableName": "name"
      },
      {
        "kind": "Variable",
        "name": "username",
        "variableName": "username"
      }
    ],
    "concreteType": "User",
    "kind": "LinkedField",
    "name": "createUser",
    "plural": false,
    "selections": [
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "id",
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
      (v2/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "SignUpMutation",
    "selections": (v3/*: any*/),
    "type": "Mutations",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v0/*: any*/),
      (v2/*: any*/),
      (v1/*: any*/)
    ],
    "kind": "Operation",
    "name": "SignUpMutation",
    "selections": (v3/*: any*/)
  },
  "params": {
    "cacheID": "72f7190fcc766bb9a2c1c7863a14bef8",
    "id": null,
    "metadata": {},
    "name": "SignUpMutation",
    "operationKind": "mutation",
    "text": "mutation SignUpMutation(\n  $email: String!\n  $username: String!\n  $name: String!\n) {\n  createUser(email: $email, username: $username, name: $name) {\n    id\n  }\n}\n"
  }
};
})() `)
