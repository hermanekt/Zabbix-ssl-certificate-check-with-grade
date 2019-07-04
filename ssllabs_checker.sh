#!/bin/bash

# Configuration
HOST=$1
ZABBIX_SENDER="/usr/bin/zabbix_sender"
ZABBIX_CONFIG="/etc/zabbix/zabbix_agentd.conf"
#ZABBIX_CONFIG=""
ZABBIX_SERVER="127.0.0.1"
ZABBIX_PORT="10051"
ZABBIX_KEY="ssllabs.certificate.grade"

SSLLAB_SCAN="/usr/lib/zabbix/externalscripts/ssllabs-scan"

#with cache
#SSLLAB_OPTIONS="-usecache -quiet -grade -maxage 1"
#without cache
SSLLAB_OPTIONS="-quiet -grade"

# Do the job
set -o errexit
ZABBIX_SENDER_CMD=$ZABBIX_SENDER
if [ -z $ZABBIX_CONFIG ]
then
    ZABBIX_SENDER_CMD="$ZABBIX_SENDER_CMD -z $ZABBIX_SERVER -p $ZABBIX_PORT "
else
    ZABBIX_SENDER_CMD="$ZABBIX_SENDER_CMD -c $ZABBIX_CONFIG "
fi

VALUE=$($SSLLAB_SCAN $SSLLAB_OPTIONS $HOST | awk 'BEGIN { FS=":" } /1/ { print $2 }'| sed -e 's/^"//' -e 's/"$//')

ZABBIX_SENDER_CMD="$ZABBIX_SENDER_CMD -s $HOST -k $ZABBIX_KEY -o $VALUE"

$ZABBIX_SENDER_CMD 1>/dev/null
