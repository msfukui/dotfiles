#!/bin/bash

#
# Precondition:
#   -f ~/.ssh/conndb.txt
#
# Layout:
#   aws-profile1:to_ssh_hostname1:local_port1:databasename1:db_port1
#   aws-profile2:to_ssh_hostname2:local_port2:databasename2:db_port2
#   ...
#
function conndb() {
  if [ -z "$1" ]; then
    echo "Usage: conndb <database>"
    return
  fi
  database=${1}

  database_list=`get_conndb_database`
  if ! printf '%s\n' "${database_list[@]}" | grep -qx "${database}"; then
    echo "Usage: conndb <database>"
    return
  fi

  host=`get_database_to_host ${database}`
  if [ -z "$host" ]; then
    echo "Error: The host is not found."
    return
  fi

  local_port=`get_database_to_local_port ${database}`
  if [ -z "$local_port" ]; then
    echo "Error: The local_port is not found."
    return
  fi

  db_port=`get_database_to_db_port ${database}`
  if [ -z "$db_port" ]; then
    echo "Error: The db_port is not found."
    return
  fi

  aws_profile=`get_database_to_aws-profile ${database}`
  if [ -z "$aws_profile" ] || [ "$AWS_PROFILE" != "$aws_profile" ]; then
    echo "Error: Please login with 'aws sso login' before the database connecting. (${aws_profile}, ${AWS_PROFILE}, ${database})"
    return
  fi

  echo "Connecting to database '${database}' via host '${host}' (local_port: ${local_port}, db_port: ${db_port}, aws_profile: ${aws_profile}) ..."
  aws ssm start-session --target "${host}" --profile "${aws_profile}" --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{"host":["'"${database}"'"],"portNumber":["'"${db_port}"'"], "localPortNumber":["'"${local_port}"'"]}'
}

_conndb() {
  local cur prev words cword split
  _init_completion || return

  if [ $cword -eq 1 ]; then
    COMPREPLY=($(compgen -W "$(get_conndb_database)" -- "$cur"))
  fi
}
complete -F _conndb conndb

function get_conndb_database() {
  if [ -f ~/.ssh/conndb.txt ]; then
    cut -d':' -f4 ~/.ssh/conndb.txt
  fi
}

function get_database_to_host() {
  if [ -z "$1" ]; then
    return
  fi
  database="$1"

  if [ -f ~/.ssh/conndb.txt ]; then
    grep $database ~/.ssh/conndb.txt | cut -d':' -f2 | head -n 1
  fi
}

function get_database_to_local_port() {
  if [ -z "$1" ]; then
    return
  fi
  database="$1"

  if [ -f ~/.ssh/conndb.txt ]; then
    grep $database ~/.ssh/conndb.txt | cut -d':' -f3 | head -n 1
  fi
}

function get_database_to_db_port() {
  if [ -z "$1" ]; then
    return
  fi
  database="$1"

  if [ -f ~/.ssh/conndb.txt ]; then
    grep $database ~/.ssh/conndb.txt | cut -d':' -f5 | head -n 1
  fi
}

function get_database_to_aws-profile() {
  if [ -z "$1" ]; then
    return
  fi
  database="$1"

  if [ -f ~/.ssh/conndb.txt ]; then
    grep $database ~/.ssh/conndb.txt | cut -d':' -f1 | head -n 1
  fi
}
