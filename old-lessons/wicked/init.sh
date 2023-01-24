#!/usr/bin/bash -

source lib/library.sh

# Color codes
reset=$(tput sgr0)
blinkRed=$(tput setab 0; tput setaf 1; tput blink)
cyan=$(tput setab 0; tput setaf 6)
magenta=$(tput setab 0; tput setaf 5)

# Standalone Script
if declare -f "$1" > /dev/null ; then
  "$@"
  case "$?" in
    0 ) echo $cyan"$1()"$reset " returned 0" ;;
    1 ) echo $cyan"$1()"$reset " returned 1" ;;
    2 ) echo $cyan"$1()"$reset " returned 2" ;;
  esac
else
  echo $blinkRed"Usage: $0 function_name"$reset >&2
  echo $magenta"You typed :: $@"$reset
  echo -e $cyan"\n** List of funcs **"$reset
  declare -F | awk '{ print $3 "()" }'
fi

exit 0
