workflow "Echo" {
  on = "push"
  resolves = ["Hello World"]
}

action "Hello World" {
  uses = "./action-a"
  secrets = ["GITHUB_TOKEN"]
}
