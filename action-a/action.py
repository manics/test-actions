#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import os
from pprint import pprint
from subprocess import (
    check_call,
    check_output
)


def get_textfile_at_commit(commit, filepath):
    ver = check_output(['git', 'show', '{}:{}'.format(commit, filepath)])
    return ver.decode()


for k in sorted(os.environ):
    if k != 'GITHUB_TOKEN':
        print('{}={}'.format(k, os.getenv(k)))

print(check_output(['git', 'config', '-l']).decode())
# print(check_output(['git', 'config', '-l', '--global']))

if (os.getenv('GITHUB_EVENT_NAME') == 'push') and (
        os.getenv('GITHUB_REF') == 'refs/heads/master'):
    with open(os.getenv('GITHUB_EVENT_PATH')) as f:
        event = json.load(f)
    pprint(event)

    before = event['before']
    after = event['after']

    ver_before = get_textfile_at_commit(before, 'VERSION.txt').strip()
    ver_after = get_textfile_at_commit(after, 'VERSION.txt').strip()

    if ver_before == ver_after:
        print('{} unchanged'.format(ver_after))
    else:
        print('{} → {}'.format(ver_before, ver_after))
        check_call(['git', 'tag', ver_after])
        check_call(['git', 'push', 'origin', 'master'])

print(check_output(['git', 'tag']).decode())
