#!/bin/bash
# Author: Tony G. <tonyskapunk@tonyskapunk.net>

kill_descendents() {
    parents=($@)
    for parent in ${parents[@]}; do
        children=($(ps --ppid $parent -o pid --no-header))
        echo "Parent: $parent with:  ${#children[@]}"
        echo "Children: ${children[@]}"
        if [[ ${#children[@]} == 0 ]]; then
            echo "kill $parent"
            continue
        else
            kill_descendents ${children[@]}
        fi
        
    done
}

parent=($1)
kill_descendents ${parent[@]}
