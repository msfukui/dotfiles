#!/bin/bash

for file in *.dot
do
  if [ -d $file ]; then
    cd $file
    for subfile in *.dot
    do
      if [ -d $subfile ]; then
        echo "[$file/$subfile]"
        diff -r ${HOME}/.${file%.*}/${subfile%.*} $subfile
      else
        echo "[$file/$subfile]"
        diff ${HOME}/.${file%.*}/.${subfile%.*} $subfile
      fi
    done
    cd ..
  else
    echo "[$file]"
    diff ${HOME}/.${file%.*} $file
  fi
done
