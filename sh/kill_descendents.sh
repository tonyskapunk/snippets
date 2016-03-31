#!/bin/bash
# Author: Tony G. <tonyskapunk@tonyskapunk.net>

kill_descendents() {
  parents=($@)
  echo -n "got: ${parents[@]} "
  if [[ ${#parents[@]} == 0 ]]; then
    return
  fi
  for parent in ${parents[@]}; do
    children=($(ps --ppid $parent -o pid --no-header))
    echo "Parent: $parent with:  ${#children[@]} Children: ${children[@]}"
    kill_descendents ${children[@]}
    echo "kill $parent"
  done
}

parent=($1)
kill_descendents ${parent[@]}
