#! /bin/sh
SERVER=$1
TIMEOUT=2
#RETVAL=0
#TIMESTAMP=`echo | date`
PORT=$2
SNI=$3
ISSUER=`timeout $TIMEOUT openssl s_client -connect ${SERVER}:${PORT} -servername $SNI 2>/dev/null | openssl x509 -noout -issuer 2>/dev/null | grep issuer`
echo ${ISSUER}
