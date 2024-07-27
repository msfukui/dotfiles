#!/bin/bash

function awslogout() {
  unset AWS_PROFILE
  unset AWS_DEFAULT_PROFILE

  echo "aws sso logout"
  command aws sso logout
}
