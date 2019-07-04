#!/bin/bash
EXTERNALSCRIPTS=/usr/lib/zabbix/externalscripts
echo "$EXTERNALSCRIPTS/ssllabs_checker.sh $1" | at now

