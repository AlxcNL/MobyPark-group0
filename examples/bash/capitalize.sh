#!/usr/bin/env bash

# Author: J.A.Boogaard@hr.nl
# Requires python3

argument_values=("$@")
nr_of_arguments=${#argument_values[@]}

if [ $nr_of_arguments -lt 1 ]
then
    printf "USAGE: %s [sentence]\n" "$0"
    exit -1
else
    sentence="$1"
fi

cmd="python -c 'print(\"$sentence\".capitalize())'"
eval $cmd
