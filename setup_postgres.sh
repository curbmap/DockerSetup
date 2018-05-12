#!/bin/bash
#start
createuser -p 9020 -d -l -E testing
createdb -p 9020 -O testing CurbMapUsers
psql -p 9020 -f /builddb.sql CurbMapUsers
psql -p 9020 -c "alter ROLE testing WITH password 'testing'"
