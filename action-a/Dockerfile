FROM debian:9.5-slim

LABEL "com.github.actions.name"="Hello World"
LABEL "com.github.actions.description"="Write arguments to the standard output"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/manics/test-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="http://github.com/manics"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]