#!/bin/bash
while true; do
    docker cp api-prod:/usr/src/app/logs/. /opt/docker/monitoring/api-logs/ 2>/dev/null
    sleep 10
done
