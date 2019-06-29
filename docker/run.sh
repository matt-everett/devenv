#!/bin/bash

source ${HOME}/.pyenvrc

echo "Syncing requirements..."
# Needs to be sourced to alter environment variables
source sync-requirements
echo "Finished syncing requirements."

echo "Starting sleep loop..."
while true; do
    sleep 1
done
