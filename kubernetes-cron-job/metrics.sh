#!/bin/sh

# Directory to store metrics files
METRICS_DIR="/data"

# Pull node metrics using node_exporter
node_exporter_metrics=$(curl -s http://node-exporter-service:9100/metrics | grep -E 'node_memory_MemTotal_bytes|node_memory_MemFree_bytes|node_cpu_seconds_total|node_filesystem_size_bytes|node_filesystem_free_bytes')

# Create filename with timestamp
filename="metrics_$(date +'%Y%m%d%H%M%S').txt"

# Write metrics to file
echo "$node_exporter_metrics" | tee "$METRICS_DIR/$filename"
