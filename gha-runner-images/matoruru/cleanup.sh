#!/bin/bash

set -Eeo pipefail
set -x

trap catch ERR

# exit 0を返せないと後続のstepに進む前にFailedになってしまうので必ずexit 0で終了させる
catch() {
  echo "Trap ERR! exit 0 for run job"
  exit 0
}

DATE=$(date "+%Y/%m/%d %H:%M:%S")
echo "${DATE} Job completed: ${GITHUB_REPOSITORY} ${GITHUB_JOB}"
echo "${DATE} WORKFLOW: ${GITHUB_WORKFLOW}"
echo "${DATE} RUNNER_NAME: ${RUNNER_NAME}"
echo "${DATE} RUN_ID": "${GITHUB_RUN_ID}"

docker logout private-registry.local:5000