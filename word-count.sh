#!/bin/bash

hadoop fs -rm -r -f output/word-count

rm -rf word-count
mkdir -p word-count

echo "Hello World" > word-count/file1.txt
echo "Hello Hadoop" > word-count/file2.txt

hadoop fs -mkdir -p input
hadoop fs -put word-count input

hadoop jar /opt/hadoop-3.0.0/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.0.0.jar wordcount input/word-count output/word-count

hadoop fs -cat output/word-count/part-r-00000
