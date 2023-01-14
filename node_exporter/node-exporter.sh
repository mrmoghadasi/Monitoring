#!/bin/bash
NODE_EXPORTER_VERSION=$(curl -sL https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep "tag_name"   | sed -E 's/.*"([^"]+)".*/\1/'|sed 's/v//')
#NODE_EXPORTER_VERSION="1.3.1"
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
tar -xzvf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
cd node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64
yes | cp node_exporter /usr/local/bin

# create user
useradd --no-create-home --shell /bin/false node_exporter

chown node_exporter:node_exporter /usr/local/bin/node_exporter
