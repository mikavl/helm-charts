#!/bin/bash

set -e

# Copy s6 configuration to a writable directory
cp --archive /config/s6 /run/rutorrent

exec "$@"
