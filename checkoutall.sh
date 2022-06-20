#!/bin/bash

if [ "$1" = "development" ] || [ "$1" = "main" ]; then
  git submodule foreach "git checkout $1 && git pull || :"
else
  printf "You must supply dev or prod as arguments to the script\n"
fi