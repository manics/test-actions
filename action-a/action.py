#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import os
from pprint import pprint
from subprocess import check_output


def get_textfile_at_commit(commit, filepath):
    return run_git('show', '{}:{}'.format(commit, filepath))


def run_git(*args):
    cmd = ['git'] + list(args)
    print(' '.join(cmd))
    out = check_output(cmd)
    return out.decode().strip()


for k in sorted(os.environ):
    if k != 'GITHUB_TOKEN':
        print('{}={}'.format(k, os.getenv(k)))

print('Local git config')
print(run_git('config', '-l', '--local'))
print('Global git config')
print(run_git('config', '-l', '--global'))
taglist = run_git('tag').split()
print('Current tags: {}'.format(taglist))

if (os.getenv('GITHUB_EVENT_NAME') == 'push') and (
        os.getenv('GITHUB_REF') == 'refs/heads/master'):
    with open(os.getenv('GITHUB_EVENT_PATH')) as f:
        event = json.load(f)
    pprint(event)

    before = event['before']
    after = event['after']

    ver_before = get_textfile_at_commit(before, 'VERSION.txt')
    ver_after = get_textfile_at_commit(after, 'VERSION.txt')
    print('{} → {} ({} → {})'.format(ver_before, ver_after, before, after))
    assert run_git('rev-parse', 'HEAD') == after

    if ver_before == ver_after and ver_after not in taglist:
        print('WARNING: Version unchanged in this push but tag does not exist')

    if ver_after not in taglist:
        print('Tagging {}'.format(ver_after))
        run_git('tag', ver_after)
        run_git('push', 'origin', ver_after)
