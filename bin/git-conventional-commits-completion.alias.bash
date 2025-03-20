#!/bin/bash

# Commands to complement conventional commits
# cf. https://www.conventionalcommits.org/ja/v1.0.0/
# Precondition: Need to install git and fzf
gcccc () {
  git rev-parse 2> /dev/null
  if [ "$?" != "0" ]; then
    return
  fi

  local branchname="$(git branch --contains | grep "^*" | cut -d' ' -f2)"
  if [ "$branchname" = "" ]; then
    return
  fi
  local issue="$(git branch --contains | grep "^*" | cut -d' ' -f2 | cut -d'.' -f1)"

  local str_pull="git pull origin $branchname"
  local str_add="git add  "
  local str_push="git push origin $branchname"

  if [[ "$issue" =~ ^[0-9]+$ ]]; then
    local str_commit_empty="git commit --allow-empty -m \"chore: #$issue \""
    local str_commit_build="git commit -m \"build: #$issue \""
    local str_commit_chore="git commit -m \"chore: #$issue \""
    local str_commit_ci="git commit -m \"ci: #$issue \""
    local str_commit_docs="git commit -m \"docs: #$issue \""
    local str_commit_fix="git commit -m \"fix: #$issue \""
    local str_commit_feat="git commit -m \"feat: #$issue \""
    local str_commit_pref="git commit -m \"pref: #$issue \""
    local str_commit_refactor="git commit -m \"refactor: #$issue \""
    local str_commit_revert="git commit -m \"revert: #$issue \""
    local str_commit_style="git commit -m \"style: #$issue \""
    local str_commit_test="git commit -m \"test: #$issue \""
  else
    local str_commit_empty="git commit --allow-empty -m \"chore: \""
    local str_commit_build="git commit -m \"build: \""
    local str_commit_chore="git commit -m \"chore: \""
    local str_commit_ci="git commit -m \"ci: \""
    local str_commit_docs="git commit -m \"docs: \""
    local str_commit_fix="git commit -m \"fix: \""
    local str_commit_feat="git commit -m \"feat: \""
    local str_commit_pref="git commit -m \"pref: \""
    local str_commit_refactor="git commit -m \"refactor: \""
    local str_commit_revert="git commit -m \"revert: \""
    local str_commit_style="git commit -m \"style: \""
    local str_commit_test="git commit -m \"test: \""
  fi

  local str="$(printf "$str_add\n$str_commit_build\n$str_commit_chore\n$str_commit_ci\n$str_commit_docs\n$str_commit_fix\n$str_commit_feat\n$str_commit_pref\n$str_commit_refactor\n$str_commit_revert\n$str_commit_style\n$str_commit_test\n$str_commit_empty\n$str_push\n$str_pull" | fzf -q "$READLINE_LINE")"
  if [ "$str" = "" ]; then
    return
  fi

  READLINE_LINE="$str"
  let READLINE_POINT=$((${#str}-1))
}
bind -x '"\C-p": gcccc'
