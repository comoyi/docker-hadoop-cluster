#!/bin/bash

hadoop_version=3.0.0
image_version=0.0.1

# Download
if [[ ! -f "hadoop-${hadoop_version}.tar.gz" ]]; then
    echo "hadoop-${hadoop_version}.tar.gz not exist start download..."
    echo ""
    wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-${hadoop_version}/hadoop-${hadoop_version}.tar.gz
fi

# Check
sha256sum -c hadoop.sha256sum > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "Check sha256sum error, please delete hadoop-${hadoop_version}.tar.gz and rerun this script."
    exit
fi

# Build image
echo "Start build image"
docker build -t comoyi/hadoop:${image_version} .
