FROM python:3.7-alpine

LABEL "com.github.actions.name"="Wait for Travis"
LABEL "com.github.actions.description"="Wait for Travis to return a status"
LABEL "com.github.actions.icon"="clock"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="http://github.com/manics/test-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="http://github.com/manics"

RUN apk --no-cache add git && \
    pip3 install requests
ADD wait_for_travis.py /wait_for_travis.py
CMD ["/wait_for_travis.py"]
