#!/bin/bash

set -u
set -e

MOUNT_USER="mountuser"
MOUNT_USER_EXISTS=$(cat /etc/passwd | grep "${MOUNT_USER}" | wc -l)

if [ "${MOUNT_USER_EXISTS}" = "0" ]; then
    # Seriously, who does this? It stops adduser and addgroup from working because NOFOLLOW
    mv /root/.acl/group /etc/group
    mv /root/.acl/passwd /etc/passwd

    addgroup --gid="${PGID}" "${MOUNT_USER}"
    adduser --system --home=/ --no-create-home --shell=/bin/bash --uid="${PUID}" --gid="${PGID}" "${MOUNT_USER}"
fi

exec juicefs mount \
    --cache-dir "/juicefs-cache" \
    --cache-size "102400" \
    -o auto_unmount \
    -o user_id="${PUID}" \
    -o group_id="${PGID}" \
    "${JUICEFS_REDIS_URL}" \
    /mnt
