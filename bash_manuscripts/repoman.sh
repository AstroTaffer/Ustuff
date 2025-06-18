#!/bin/bash
# Repository hub manager

usage()
{
	echo 'Execute REPO_CMD command in every subdirectory that is a Git repository (non-recursive)

    REPO_CMDs:
	status	-	git branch + git status
	fetch	-	git fetch -p --all
	pull	-	[fetch] + git pull --ff-only
	goto	-	git checkout
	clean	-	git clean -dfx + git reset --hard HEAD

    Options:
    -p, --path      -   path to working directory (pwd otherwise)
    -t, --target    -   checkout target for [goto] (default branch otherwise)'
	exit 1
}


# ----- READING PARAMETERS ----- #
REPO_CMD=""
WDIR=$(pwd)
TARGET=""

while (( $# > 0 )); do
    case $1 in
        -p)
            ;&
        --path)
            shift
            if (( $# == 0 )); then
                echo -e "\e[31m""No path provided""\e[0m"
                exit 1
            else
                WDIR=$1
            fi
            ;;
        -t)
            ;&
        --target)
            shift
            if (( $# == 0 )); then
                echo -e "\e[31m""No goto provided""\e[0m"
                exit 1
            else
                TARGET=$1
            fi
            ;;
        *)
            if [[ ${REPO_CMD} == "" ]]; then
                REPO_CMD=$1
            else
                echo -e "\e[31m""Too much REPO_CMDs""\e[0m"
                exit 1
            fi
            ;;
    esac

    shift
done

[[ ${REPO_CMD} == "" ]] && usage


# ----- EXECUTING REPO_CMD ----- #
cd $WDIR

for repo in */.git
do
	echo -e "\n\e[0;36m" "Entering ${repo%/*}:" "\e[0m"
	cd $repo/..

	case $REPO_CMD in
		status)
			git branch
			git status
			;;
		fetch)
			git fetch -p --all --tags
			;;
		pull)
			git fetch -p --all --tags
			git pull --ff-only
			;;
		goto)
            if [[ ${TARGET} == "" ]]; then
                checkout_target=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
            else
                checkout_target=$TARGET
            fi
			git checkout $checkout_target
			;;
		clean)
			git clean -dfx
			git reset --hard HEAD
			;;
        *)
            echo -e "\e[31m""Invalid command""\e[0m"
            exit 1
	esac

	cd ..
done

echo -e "\n\e[1;32m" "Done!" "\e[0m"

