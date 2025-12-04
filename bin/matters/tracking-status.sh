#!/bin/bash

set -e

# tracking-status-clockify-update.sh > $TIME_STATUS_FILE.log 2>&1 &
tracking-status-clickup-update.sh > $TIME_STATUS_FILE.log 2>&1 &

cat $TIME_STATUS_FILE
