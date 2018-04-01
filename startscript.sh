#!/bin/bash
rm /builddb.sql /pgdg-ami201503-96-9.6-2.noarch.rpm /setup_mongo.sh /setup_redis.sh setup_postgres.sh /*.js
service mongod stop
rm /var/run/mongodb/mongod.pid
service mongod start
service postgresql96 start
cd curbmapbackend-js
git checkout testing
yarn install --force
yarn start &

cd .. 
cd curbmapauth-js
git checkout testing
yarn install --force
yarn start &
cd ..



