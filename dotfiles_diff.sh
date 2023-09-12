#!/bin/bash

for file in *.dot
do
  if [ -d $file ]; then
    echo "[$file]"
    diff -r ${HOME}/.${file%.*} $file
  else
    echo "[$file]"
    diff ${HOME}/.${file%.*} $file
  fi
done
