#!/bin/bash

echo "Syncing requirements..."
sync-requirements
echo "Finished syncing requirements."

echo "Starting sleep loop..."
while true; do
    sleep 1
done
