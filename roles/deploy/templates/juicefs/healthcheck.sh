#!/bin/bash

set -u
set -e

JUICEFS_RUNNING=$(ps x | grep "juicefs mount" | grep -v grep | wc -l)
FUSE_MOUNTED=$(mount | grep "fuse\.juicefs" | wc -l)

if [ "${JUICEFS_RUNNING}" = "0" ]; then
    echo "JuiceFS is not running!"
    exit 1
fi

if [ "${FUSE_MOUNTED}" = "0" ]; then
    echo "FUSE is not mounted!"
    exit 1
fi
