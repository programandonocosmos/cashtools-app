module Mutation = %relay(`
  mutation SignUpMutation ($username: String!, $name: String!, $email: String!) {
	createUser(username: $username, name: $name, email: $email) {
    id
  }
  }
`)
