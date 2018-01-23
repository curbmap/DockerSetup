#!/bin/bash
cd /usr/local/src/redis-4.0.4
make distclean
make redis-server
make redis-cli
make redis-benchmark
make -ike test
mkdir -p /etc/redis /var/lib/redis /var/redis/50005
cp src/redis-server src/redis-cli /usr/local/bin