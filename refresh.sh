#!/bin/sh

URL=$1
FILE=$2
FILE2=$3
HASH=$(md5sum "$(readlink -f "${FILE}")")
HASH2=$(md5sum "$(readlink -f "${FILE2}")")

echo ">>>>>>>>>>>>>>>>>>>>>>>"
echo "[$(date +%s)] Starting Prometheus Reloader";
echo "[$(date +%s)] Loaded files:"
echo "[$(date +%s)]    - ${FILE}"
echo "[$(date +%s)]    - ${FILE2}"
echo "[$(date +%s)] Waiting for file changes..."; echo


while true; do
   NEW_HASH=$(md5sum "$(readlink -f "${FILE}")")
   if [ "$HASH" != "$NEW_HASH" ]; then
     HASH="$NEW_HASH"
     echo "[$(date +%s)] Trigger refresh due to ${FILE} change"
     curl -sSL -X POST "${URL}" > /dev/null
   fi
   NEW_HASH2=$(md5sum "$(readlink -f "${FILE2}")")
   if [ "$HASH2" != "$NEW_HASH2" ]; then
     HASH2="$NEW_HASH2"
     echo "[$(date +%s)] Trigger refresh due to ${FILE2} change"
     curl -sSL -X POST "${URL}" > /dev/null
   fi
   sleep 5
done
