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

#Delete the branch in gihub
curl -s -H "Authorization: token ${GITHUB_API_KEY}" -X DELETE https://api.github.com/repos/${GITHUB_USER}/${GITHUB_PROJECT}/git/refs/heads/${NEW_BRANCH_PREFIX}${1}


. /usr/local/bin/azure_cli_virtual_env/bin/activate

az group delete -y -n ${NEW_BRANCH_PREFIX}${1}-noc-rg

 

