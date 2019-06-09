workflow "Wait and tag" {
  resolves = ["Tag if changed"]
  on = "push"
}

# Filter for master branch
action "Master" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Wait for Travis" {
  needs = "Master"
  uses = "./wait-for-travis"
}

action "Tag if changed" {
  uses = "./action-a"
  needs = ["Wait for Travis"]
  secrets = ["GITHUB_TOKEN"]
}
