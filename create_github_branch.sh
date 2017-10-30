#!/bin/bash

#set -x
set -e

export GITHUB_USER=awalker125
export GITHUB_PROJECT=mcv-azure-arm-noc
export SOURCE_BRANCH=master
export NEW_BRANCH_PREFIX=dev


if [ -z "${GITHUB_API_KEY}" ]
then
	echo GITHUB_API_KEY is not set. Exiting...
	exit 99
fi

if [ -z "${1}" ]
then
	echo "no id supplied. Exiting..."
	exit 98
fi

export SOURCE_REF=$(curl -s -H "Authorization: token ${GITHUB_API_KEY}" https://api.github.com/repos/${GITHUB_USER}/${GITHUB_PROJECT}/git/refs | jq '.[]  | select(.ref == "refs/heads/'${SOURCE_BRANCH}'") | .object.sha')

if [ -z "${SOURCE_REF}" ]
then
	echo "Failed to retrieve source ref.."
	exit 97
fi

#Delete the branch if it already exists
curl -s -H "Authorization: token ${GITHUB_API_KEY}" -X DELETE https://api.github.com/repos/${GITHUB_USER}/${GITHUB_PROJECT}/git/refs/heads/${NEW_BRANCH_PREFIX}${1}

curl -s -H "Authorization: token ${GITHUB_API_KEY}" \
-X POST --header 'Content-Type: application/json' https://api.github.com/repos/${GITHUB_USER}/${GITHUB_PROJECT}/git/refs \
-d '{"ref":"refs/heads/'${NEW_BRANCH_PREFIX}${1}'","sha":'${SOURCE_REF}'}'


 

