#!/bin/bash

usage()
{
	echo 'Execute Git TARGET command in every subdirectory (non-recursive):
	check	-	git branch + git status
	fetch	-	git fetch --prune --all
	pull	-	[fetch] + git pull
	stock	-	git checkout {default_branch}
	reset	-	clean -dfx + git reset --hard HEAD'
	exit 1
}

TARGET="$1"
[ "$TARGET" == "" ] && usage

WDIR="$2"
[ "$WDIR" == "" ] && WDIR=$(pwd)
cd $WDIR

for repo in */.git
do
	echo -e "\n\033[0;36m" "Entering ${repo%/*}:" "\033[0m"
	cd $repo/..

	case $TARGET in
		check)
			git branch
			git status
			;;
		fetch)
			git fetch --prune --all
			;;
		pull)
			git fetch --prune --all
			git pull
			;;
		stock)
			default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
			git checkout $default_branch
			;;
		reset)
			git clean -dfx
			git reset --hard HEAD
			;;
	esac

	cd ..
done

echo -e "\n\033[1;32m" "Done!" "\033[0m"

