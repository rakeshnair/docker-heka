#! /bin/bash -e

if [[ -z "$KAFKA_ACK" ]]; then
    export KAFKA_ACK=WaitForAll
fi
if [[ -z "$KAFKA_CLIENT_ID" ]]; then
    export KAFKA_CLIENT_ID=`hostname`
fi
if [[ -z "$HEKA_MAXPROCS" ]]; then
    export HEKA_MAXPROCS=2
fi

echo $HEKA_MAXPROCS
/usr/local/heka/bin/hekad -config="/usr/local/etc/heka/hekad.toml"
