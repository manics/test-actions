FROM alpine:3.9

LABEL "com.github.actions.name"="Test GitHub push"
LABEL "com.github.actions.description"="Test modifying and pushign to a GitHub repository"
LABEL "com.github.actions.icon"="chevrons-right"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="http://github.com/manics/test-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="http://github.com/manics"

RUN apk --no-cache add git
ADD action.sh /action.sh
CMD ["/action.sh"]
