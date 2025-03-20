#!/bin/bash

wiki () {
  if [ ! -d ${HOME}/vimwiki ]; then
    echo "vimwiki directory not found."
    return
  fi
  if [[ $# == 0 ]]; then
    vim +"VimwikiIndex"
  elif [[ $1 == "daily" ]]; then
    message="daily commit and push: `date '+%Y-%m-%d'`"
    git -C ${HOME}/vimwiki/ add .
    git -C ${HOME}/vimwiki/ commit -m "$message"
    git -C ${HOME}/vimwiki/ push
  else
    subcommand=$1
    shift
    params=''
    for param in "$@"
    do
      if [[ $param == *' '* ]]; then
        params="${params} \"${param}\""
      else
        params="${params} ${param}"
      fi
    done
    if [[ $params == '' ]]; then
      git -C ${HOME}/vimwiki/ $subcommand
    else
      eval git -C ${HOME}/vimwiki/ $subcommand "$params"
    fi
  fi
}
___git_complete wiki __git_main
