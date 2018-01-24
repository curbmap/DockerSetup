#!/bin/bash
pkill node
cd /services/curbmapbackend-js && git pull && yarn install && yarn start
cd /services/curbmapauth-js && git pull && yarn install && yarn start