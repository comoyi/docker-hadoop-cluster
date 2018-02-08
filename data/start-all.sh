#!/bin/bash

$HADOOP_HOME/sbin/start-all.sh

$HADOOP_HOME/bin/mapred --daemon start historyserver
