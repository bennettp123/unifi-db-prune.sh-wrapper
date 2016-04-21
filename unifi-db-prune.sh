#!/bin/bash

CONFIG_FILE="$(dirname "$0")/config.sh"
[ -e "$CONFIG_FILE" ] && . "$CONFIG_FILE"

MONGO="${MONGO:-mongo}"
MONGOD_HOST="${MONGOD_HOST:-localhost}"
MONGOD_PORT="${MONGOD_PORT:-27117}"
PRUNE_SCRIPT="${PRUNE_SCRIPT:-$(dirname "$0")/mongo_prune_js.js}"

LOGFILE="$(mktemp)"
RETVAL=0

function cleanup {
  rm -f "$LOGFILE"
}
trap "rm -f \"$LOGFILE\"" EXIT

# send output to logfile and syslog
exec 3>&1 1> >(exec tee "$LOGFILE" >(exec logger -t "$(basename "$0")") >/dev/null) 2>&1

echo "Using $MONGO ..."
echo " server $MONGOD_HOST:$MONGOD_PORT"
echo " prune script $PRUNE_SCRIPT"

if ! systemctl is-active unifi >/dev/null; then
  echo "Error: unifi is not runnning!" >&2
  RETVAL=1
fi

if [ $RETVAL -eq 0 ]; then
  "$MONGO" --port "$MONGOD_PORT" < "$PRUNE_SCRIPT"
  RETVAL=$?
fi

# if there was an error, print logfile to stdout, otherwise be quiet
if [ $RETVAL -ne 0 ]; then cat "${LOGFILE}" >&3 2>&1; fi

exit $RETVAL

