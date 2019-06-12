workflow "Other test" {
  on = "push"
  resolves = ["Test GitHub push"]
}

# Filter for master branch
action "Master2" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Test GitHub push" {
  needs = ["Master2"]
  uses = "./test-gh-push"
  secrets = ["GITHUB_TOKEN"]
}
