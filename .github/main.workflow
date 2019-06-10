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

action "Docker build" {
  uses = "actions/docker/cli@master"
  args = "build -t manics/test-actions-github ."
}

action "Docker login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker push" {
  uses = "actions/docker/cli@master"
  needs = ["Docker build", "Docker login"]
  args = "push manics/test-actions-github ."
}
