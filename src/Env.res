type vars = {apiUrl: string}
type config = {extra: vars}

@module("expo-constants") @scope("default") external expoConfig: config = "expoConfig"
let apiUrl = expoConfig.extra.apiUrl

let env = expoConfig.extra
