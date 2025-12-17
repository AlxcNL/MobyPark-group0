#!/usr/bin/env bash
#
# Author: J.A.Boogaard@hr.nl#

if [[ -n "$1" ]]; then
    logfile="$1"
else
    exit "Provide a logfile"
fi

cmd="curl --location --request POST $PAPERTRAIL_URL"
cmd="${cmd} --header 'Content-Type: application/octet-stream'"
cmd="${cmd} --header 'Authorization: Bearer $PAPERTRAIL_TOKEN'"
cmd="${cmd} --data-binary '@${logfile}'"

echo $cmd
eval $cmd
