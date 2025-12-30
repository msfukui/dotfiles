#!/bin/bash

function awslogin() {
  if [ -z "$1" ]; then
    echo "Usage: awslogin <profile-name>"
    return
  fi
  env=${1}

  env_list=`get_aws-profiles`
  if ! printf '%s\n' "${env_list[@]}" | grep -qx "${env}"; then
    echo "Usage: awslogin <profile-name>"
    return
  fi

  export AWS_PROFILE=${env}
  export AWS_DEFAULT_PROFILE=${env}

  echo "aws sso login --profile ${env}"
  command aws sso login --profile ${env}
}

_awslogin() {
  local cur prev words cword split
  _init_completion || return

  if [ $cword -eq 1 ]; then
    COMPREPLY=($(compgen -W "$(get_aws-profiles)" -- "$cur"))
  fi
}
complete -F _awslogin awslogin

function get_aws-profiles() {
  if [ -f ~/.aws/credentials ]; then
    grep '^\[' ~/.aws/credentials | tr -d '\]' | tr -d '['
    return
  fi
  if [ -f ~/.aws/config ]; then
    grep '^\[' ~/.aws/config | tr -d '\]' | tr -d '[' | cut -d' ' -f2
  fi
}
