#!/bin/bash
yum install -y bzip2
wget https://curbmap.com:50003/uploads/maplinesdb.tar.bz2
tar xvf maplinesdb.tar.bz2
rm *bz2
service mongo stop
service mongo start
mongoimport -u testing -p testing --authenticationDatabase admin  --db MapLinesDB  --collection MapLines MapLinesDB.json -h 127.0.0.1:27017
mongoimport -u testing -p testing --authenticationDatabase admin  --db MapLinesDB  --collection Photos Photos.json -h 127.0.0.1:27017
mongoimport -u testing -p testing --authenticationDatabase admin  --db MapLinesDB  --collection Lines Lines.json -h 127.0.0.1:27017
rm *json
echo "Data imported"