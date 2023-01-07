#!/bin/bash
mkdir /etc/blackbox_exporter/
wget -p /etc/blackbox_exporter/ https://raw.githubusercontent.com/mrmelec/Monitoring/main/blackbox_exporter/blackbox.yml
docker run --rm -d -p 9115:9115 --name blackbox_exporter -v `pwd`:/config prom/blackbox-exporter:master --config.file=/etc/blackbox_exporter//blackbox.yml
