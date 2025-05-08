#!/bin/bash

git branch -D $1
git push origin --delete $1
git fetch --all --prune
