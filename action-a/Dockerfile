FROM python:3.7-alpine

LABEL "com.github.actions.name"="Hello World"
LABEL "com.github.actions.description"="Write arguments to the standard output"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/manics/test-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="http://github.com/manics"

RUN apk --no-cache add git
ADD action.py /action.py
CMD ["/action.py"]
