#!/bin/bash
# Verifies checksums from installed package files
# Will print any file that does not match the checksum when installed.

TMP_IFS=$IFS
IFS="$(echo -ne "\n\b")"

for pkg in $(find /var/lib/dpkg/info/ -type f -name "*md5sums")
do
  for md5_file in $(cat $pkg)
  do
    md5=$(echo $md5_file|awk -F ' ' '{print $1}')
    file=$(echo $md5_file|awk -F ' ' '{printf "/%s", $2}')
    if [[ "$(md5sum $file|awk '{print $1}')" != $md5 ]]
    then
      echo $file
    fi
  done;
done

IFS=$TMP_IFS
