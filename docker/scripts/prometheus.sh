#!/usr/bin/env sh
set -e

prom_config="/sidecars/etc/prometheus.yml"

cat /sidecars/etc/prometheus.default.yml > "$prom_config"

# Start and run prometheus
exec /sidecars/bin/prometheus --config.file="$prom_config" --storage.tsdb.path=/prometheus --storage.tsdb.retention.time=2h --storage.tsdb.min-block-duration=30m --storage.tsdb.max-block-duration=30m --web.enable-lifecycle
