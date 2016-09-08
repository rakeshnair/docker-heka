FROM segment/base:v4

RUN apt-get install -y vim

# Download and place Heka binaries
ENV HEKA_FILE_NAME heka-0_10_0-linux-amd64
ENV HEKA_VERSION 0.10.0
ENV HEKA_DOWNLOAD_URL https://github.com/mozilla-services/heka/releases/download/v$HEKA_VERSION/$HEKA_FILE_NAME.tar.gz
ENV HEKA_MD5 89ff62fe2ccad3d462c9951de0c15e38

RUN cd /usr/local && \
    curl -LO $HEKA_DOWNLOAD_URL && \
    echo "$HEKA_MD5  $HEKA_FILE_NAME.tar.gz" | md5sum --check && \
    echo "$HEKA_FILE_NAME.tar.gz" | xargs tar -zxf && \
    mv $HEKA_FILE_NAME heka && \
    rm -rf $HEKA_FILE_NAME.tar.gz

# Place the config file required for startup
RUN mkdir /usr/local/etc/heka
COPY include/etc/heka/hekad.toml /usr/local/etc/heka

# Create log directory
RUN mkdir /var/log/heka

# Create volume that will contain data to be tailed
RUN mkdir /data && chmod 744 /data
VOLUME /data

# Place the startup scripts
RUN mkdir /usr/local/etc/init.d
COPY include/etc/init.d/heka-start.sh /usr/local/etc/init.d/heka-start.sh
RUN chmod +x /usr/local/etc/init.d/heka-start.sh

CMD ["bash", "-C", "/usr/local/etc/init.d/heka-start.sh"]

