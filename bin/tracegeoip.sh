#!/bin/bash
routes=$(ss -an | grep -oP "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | grep -vE "127\.0\.0\.1|0\.0\.0\.0|192\.168\.1\.4|)" | uniq)
for j in $routes; do
    ips=$(traceroute -I "$j" | grep -oP "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+(?=\))")
    for i in $ips; do
        curl -s "http://demo.ip-api.com/json/$i?fields=66842623&lang=en" | jq '.query, .city, .lat, .lon'
    done
done
