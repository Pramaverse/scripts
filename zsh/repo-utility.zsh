#!/bin/zsh
# goto-project - given a directory name, will cd to that directory

# Add the following to your .zshrc or .zprofile as well as sourcing this file.
# source ~/path/to/file/repo-utility.zsh &>/dev/null
# autoload -U compinit; compinit
# compdef _goto-project goto-project

# DEV_HOME needs to be set here if NOT set elsewhere
#export DEV_HOME="${HOME}/Developer"

DEV_DOMAINS=($(ls -d $DEV_HOME/*/))

function goto-project() {
  # $0 is the script name, $1 id the first ARG, $2 is second...
  local PROJECT_NAME="$1"
  local PROJECT_DIR
  local DOMAIN_PATH

  for DOMAIN_PATH in "${DEV_DOMAINS[@]}"
  do
    PROJECT_DIR="${DOMAIN_PATH}${PROJECT_NAME}"
    if [ -d "$PROJECT_DIR" ]; then
      # Control will enter here if $PROJECT_DIR exists.
      cd $PROJECT_DIR
      return 0
    fi
  done

  echo "Invalid project name"
  return 0
}

# Autocomplete function for goto-project.
function _goto-project() {
  local DOMAIN_PATH
  for DOMAIN_PATH in "${DEV_DOMAINS[@]}"
  do
    _path_files -/ -W "${DOMAIN_PATH%?}"
  done
}
