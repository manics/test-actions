workflow "Wait and tag" {
  on = "push"
  resolves = ["Docker Push"]
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

action "Test GitHub push" {
  needs = "Master"
  uses = "./test-gh-push"
}

action "Tag if changed" {
  uses = "./action-a"
  needs = ["Wait for Travis"]
  secrets = ["GITHUB_TOKEN"]
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  needs = ["Tag if changed"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Build" {
  uses = "actions/docker/cli@master"
  args = "build -t manics/test-actions-github ."
  needs = ["Docker Login"]
}

action "Docker Push" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Build"]
  args = "push manics/test-actions-github"
}
