#! /bin/bash

old_ifs="$IFS"


cmd="bash"

IFS=":" read -a PATH_ARR <<< "$PATH"

i=0
arr_len="${#PATH_ARR[@]}"

while (( i < "$arr_len" ))
do
  echo "${PATH_ARR[$i]}/${cmd}"
  let i++
done

IFS="$old_ifs"
