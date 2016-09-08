echo "Starting Heka..."
/usr/local/heka/bin/hekad -config="/usr/local/etc/heka/hekad.toml" >> /var/log/heka/heka.log 2>&1
