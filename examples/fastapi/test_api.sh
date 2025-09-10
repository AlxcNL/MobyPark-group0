#!/usr/bin/env bash

# Author: J.A.Boogaard@hr.nl

message="Salut"

http GET http://127.0.0.1:8000/component?text=${message}
