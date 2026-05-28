#!/bin/sh

if [ -d /data/garage ]; then
  chown nobody:nobody /data/garage
else
  install -d -m 755 -o nobody -g nobody /data/garage
  echo "No garage data found in /data/garage, creating empty directory"
fi

if [ -z "$GARAGE_RPC_SECRET" ]; then
  export GARAGE_RPC_SECRET=$(openssl rand -hex 32)
  echo "GARAGE_RPC_SECRET not set, automatically generated random secret: $GARAGE_RPC_SECRET"
fi

if [ -z "$GARAGE_ADMIN_TOKEN" ]; then
  export GARAGE_ADMIN_TOKEN=$(openssl rand -base64 32)
  echo "GARAGE_ADMIN_TOKEN not set, automatically generated random token: $GARAGE_ADMIN_TOKEN"
fi

# if [ -z "$GARAGE_METRICS_TOKEN" ]; then
#   export GARAGE_METRICS_TOKEN=$(openssl rand -base64 32)
#   echo "GARAGE_METRICS_TOKEN not set, automatically generated random token: $GARAGE_METRICS_TOKEN"
# fi

exec su-exec nobody:nobody $@
