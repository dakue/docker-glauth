#!/bin/bash
set -e

if [ -z "$2" ]
then
  exec /usr/local/bin/glauth --help
fi

echo "INFO: starting $1 ..."
exec "$@"
