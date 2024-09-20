#!/usr/bin/bash

destination="$HOME/.local/share/bin/"

for script in `ls *.sh`; do
    if [[ "$script" == "install.sh" ]]; then
        continue
    fi

    rm -f $destination$script
    cp $script $destination$script
done
