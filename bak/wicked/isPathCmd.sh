#! /bin/bash -

# Check if command is in PATH

# -- Standalone ?? --
if [[ "$BASH_SOURCE" == "$0" ]] ; then
  echo "Functions within the script, and not imported!"
fi

# --

in_path() {
  cmd="$1"
  path="$2"
  result=1

  OLD_IFS="$IFS"
  IFS=":" read -a PATH_ARR <<< "$PATH"

  for dir in "${PATH_ARR[@]}"
  do
    if [ -x "${dir}/${cmd}" ] ; then
      result=0
    fi
  done

  IFS="$OLD_IFS"
  return $result
}

isPathCmd() {
  cmd="$1"

  if [[ -z "$cmd" ]] ; then
    echo "Pass a command."
  else
    # absolute
    if [[ "${cmd:0:1}" == "/" ]]; then
      if [ ! -x "$cmd" ] ; then
        return 1
      fi
    
    # full check 
    elif  ! in_path "$cmd" "$PATH"  ; then
      return 2
    fi
  fi

  return 0
}

# Implement one functionality, and make it standalone

if [[ "$#" -ne 1 ]] ; then
  echo "Usage: $0 command" >&2
  exit 1
fi

isPathCmd "$1"

case $? in
  0 ) echo "$1 found in PATH"               ;;
  1 ) echo "$1 not found or not executable" ;;
  2 ) echo "$1 not found in PATH"           ;;
esac

# here it completes
exit 0

echo "Not part of the script, huh?"
