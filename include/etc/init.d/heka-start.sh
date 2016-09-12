echo "Starting Heka..."

if [[ -z "$KAFKA_ACK" ]]; then
    export KAFKA_ACK=WaitForAll
fi
if [[ -z "$KAFKA_CLIENT_ID" ]]; then
    export KAFKA_CLIENT_ID==`hostname`
fi

/usr/local/heka/bin/hekad -config="/usr/local/etc/heka/hekad.toml" >> /var/log/heka/heka.log 2>&1
