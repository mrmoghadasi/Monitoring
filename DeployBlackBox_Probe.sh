#!/bin/bash
mkdir /etc/blackbox_exporter/
if [ "$1" = "1" ];then
wget -O /etc/blackbox_exporter/blackbox.yml https://raw.githubusercontent.com/mrmelec/Monitoring/main/blackbox_exporter/blackbox.yml
fi
if [ "$1" = "2" ];then
wget -O /etc/blackbox_exporter/blackbox.yml https://raw.githubusercontent.com/mrmelec/Monitoring/main/blackbox_exporter/blackbox_2.yml
fi

if [ "$2" = "1" ];then
cd /etc/blackbox_exporter/
docker run --rm -d -p 9116:9115 --name blackbox_exporter -v `pwd`:/config prom/blackbox-exporter:master --config.file=/config/blackbox.yml
fi

if [ "$2" = "2" ];then
cd /etc/blackbox_exporter/
docker run --rm -d -p 9115:9115 --name blackbox_exporter -v `pwd`:/config prom/blackbox-exporter:master --config.file=/config/blackbox.yml
fi
