# Library of functions

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
    exit 1
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

validAlphaNum() {
  # Remove all other chars and see
  validChars="$(echo $1 |  sed -e 's/[^[:alnum:]]//g')"

  if [[ "$1" == "$validChars" ]] ; then
    return 0
  else
    return 1
  fi
}

# lib ends here!
