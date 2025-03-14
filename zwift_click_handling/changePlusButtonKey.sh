#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Usage: ./changePlusButtonKey.sh <key>"
    exit 1
fi

# Set the variable from the command-line argument
new_key="\"$1\""

# Use sed to replace the default key value with the new key
sed -i -e "s/\(PLUS_KEY = \).*/\1$new_key/" app.py