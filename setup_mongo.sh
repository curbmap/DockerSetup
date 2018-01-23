#!/bin/bash
rm /var/lock/subsys/mongod
s=`service mongod status`
echo $s
service mongod stop
service mongod start
s=`service mongod status`
echo $s
# Create the user
mongo admin < /testuser.js
# Create the MapLinesDB
mongo admin -u testing -p testing < testdb.js
