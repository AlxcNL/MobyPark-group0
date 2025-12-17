#!/usr/bin/env bash
#
# Author: J.A.Boogaard@hr.nl#

function post_to_papertrail() {
    message="$1"

    cmd="curl --location --request POST $PAPERTRAIL_URL"
    cmd="${cmd} --header 'Content-Type: application/octet-stream'"
    cmd="${cmd} --header 'Authorization: Bearer $PAPERTRAIL_TOKEN'"
    cmd="${cmd} --data-raw \'${message}\'"
    eval $cmd

}

while IFS= read -r line; do
    log="$(echo ${line} | xargs)"
    post_to_papertrail $log
done
