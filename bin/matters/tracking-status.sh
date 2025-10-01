#!/bin/bash

set -e

tracking-status-update.sh > $TIME_STATUS_FILE.log 2>&1 &

cat $TIME_STATUS_FILE
