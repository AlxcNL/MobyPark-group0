#!/usr/bin/env bash

logfile="$1"
logging=$(cat $logfile)
#logging="test2"

curl --location --request POST \
    "https://logs.collector.eu-01.cloud.solarwinds.com/v1/logs" \
    --header 'Content-Type: application/octet-stream' \
    --header 'Authorization: Bearer So0wMuLnDG27xH99_g354F_5xTZlIJm_9ndt319eIUDCK_mxe0SoGDRAD3-V7uDv2YvoRrs' \
    --data-raw "${logging}"
