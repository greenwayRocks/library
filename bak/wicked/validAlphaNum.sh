#!/bin/bash -

# check if input is valid alphaNum chars

validAlphaNum() {
  # Remove all other chars and see
  validChars="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"

  if [[ "$1" == "$validChars" ]] ; then
    return 0
  else
    return 1
  fi
}

# Input and check if functionality works!

read -p "Enter a string with numbers and alphabets: " input

if validAlphaNum "$input" ; then
  echo "This is a valid alphaNum input."
else
  echo "Given string is not a valid alphaNum characters." >&2
  exit 1
fi

exit 0
