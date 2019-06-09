action "Hello World" {
  uses = "./action-a"
  secrets = ["GITHUB_TOKEN"]
}

workflow "Wait and tag" {
  resolves = ["Tag if changed"]
  on = "push"
}

action "Wait for Travis" {
  uses = "./wait-for-travis"
}

action "Tag if changed" {
  uses = "./action-a"
  needs = ["Wait for Travis"]
  secrets = ["GITHUB_TOKEN"]
}
