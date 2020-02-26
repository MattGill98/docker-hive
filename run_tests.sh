#!/bin/bash

# Setup database
hive -e "create database climate"
hive --database climate -f $HIVE_HOME/conf/config.hql

# Run tests
set -e
hive -e 'SELECT station, avg(hourlydrybulbtemperature) FROM data WHERE from_unixtime(unix_timestamp(time), "YYYY-MM") = "2019-12" GROUP BY station;'
