#!/usr/bin/env bash

set -e

HIVE_BYTES=`$HADOOP_HOME/bin/hadoop fs -du -s /user/hive/warehouse`

echo "Database\tSize in Bytes"
echo "Hive (Roberto Congiu's JsonSerde)\t$HIVE_BYTES"

