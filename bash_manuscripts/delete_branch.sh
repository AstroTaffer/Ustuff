#!/bin/bash

git branch -D $1
git push origin -d $1
git fetch -p
