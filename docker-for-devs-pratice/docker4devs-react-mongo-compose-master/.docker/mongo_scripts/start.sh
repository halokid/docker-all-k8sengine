#!/usr/bin/env bash

if [[ -e /.runonce ]]; then
    echo "Kicking off entrypoint.sh script"
    /mongo_scripts/entrypoint.sh

   echo "Kicking off primer.sh script"
    /mongo_scripts/primer.sh
fi

# Start MongoDB
echo "Starting MongoDB server Mongod"
/usr/bin/mongod --auth $@
