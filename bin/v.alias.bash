#!/bin/bash

v () {
  if [ "$1" == "" ]; then
    vim .
  else
    vim $*
  fi
}
