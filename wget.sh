#!/bin/bash

wget -a logfile "http://graphite-web.intuit.net/render?target=collectd.network.QCY-C.*.*.*.snmp.*Memory*&from=-10min&until=-5min&format=json" 

    sleep 604800

