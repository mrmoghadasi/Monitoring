#!/bin/bash
wget https://raw.githubusercontent.com/mrmelec/Monitoring/main/blackbox_exporter/blackbox.yml
docker run --rm -d -p 9115:9115 --name blackbox_exporter -v `pwd`:/config prom/blackbox-exporter:master --config.file=/config/blackbox.yml
