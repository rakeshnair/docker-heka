FROM segment/base:v4

# Download and place Heka binaries
ENV HEKA_DOWNLOAD_URL https://github.com/mozilla-services/heka/releases/download/v0.10.0/heka-0_10_0-linux-amd64.tar.gz
ENV HEKA_MD5 89ff62fe2ccad3d462c9951de0c15e38

RUN cd /usr/local && \
    curl -LO $HEKA_DOWNLOAD_URL && \
    heka_file_name=$(echo $HEKA_DOWNLOAD_URL | sed -e "s/\(.*\)\(heka-.*\)\.tar\.gz/\2/") && \
    echo "$HEKA_MD5  $heka_file_name.tar.gz" | md5sum --check && \
    echo "$heka_file_name.tar.gz" | xargs tar -zxf && \
    mv $heka_file_name heka && \
    rm -rf $heka_file_name.tar.gz

# Place Heka startup script and config file
RUN mkdir /usr/local/etc/heka && \
    mkdir /usr/local/etc/init.d

COPY include/etc/heka/hekad.toml /usr/local/etc/heka
COPY include/etc/init.d/heka-start.sh /usr/local/etc/init.d/heka-start.sh

CMD ["bash", "-C", "/usr/local/etc/init.d/heka-start.sh"]
