# install node_exporter 

#!/bin/bash
NODE_EXPORTER_VERSION=$(curl -sL https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep "tag_name"   | sed -E 's/.*"([^"]+)".*/\1/'|sed 's/v//')
#NODE_EXPORTER_VERSION="1.3.1"
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz

wget https://raw.githubusercontent.com/mrmelec/Monitoring/main/node_exporter/smartmon.sh
chmod +x smartmon.sh
./smartmon.sh

tar -xzvf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
cd node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64
yes | cp node_exporter /usr/local/bin

# create user
useradd --no-create-home --shell /bin/false node_exporter

chown node_exporter:node_exporter /usr/local/bin/node_exporter


# -----------------------------------------------------------------------------------------


echo '[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter --collector.systemd  --collector.textfile.directory /var/lib/node_exporter/textfile_collector/
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/node_exporter.service

# enable node_exporter in systemctl
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter

