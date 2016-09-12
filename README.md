Heka
====

Dockerfile for [Heka](https://hekad.readthedocs.io/en/v0.10.0/) version `v0.10.0`.

This Docker image has been pre-configured to read events from an input file, using the [`LogstreamerInput`](http://hekad.readthedocs.io/en/v0.10.0/config/inputs/logstreamer.html) plugin and send them to Kafka using the [`KafkaOutput`](https://hekad.readthedocs.io/en/v0.10.0/config/outputs/kafka.html) plugin.

Environment variables
=====================
The following environment variables should be set for the Heka container to run:
- Environment variables required for the `LogstreamerInput` plugin:
  - `DATA_DIR`: The local file system directory, containing files that should be tailed by Heka. 
  - `FILE_MATCH`: Regular expression used to match files located under the `DATA_DIR`.

  More info on the `LogstreamerInput` plugin availabe [here.](http://hekad.readthedocs.io/en/v0.10.0/config/inputs/logstreamer.html)
- Environment variables required for the `KafkaOutput` plugin:
  - `KAFKA_TOPIC` : The Kafka topic to which events will be published.
  - `KAFKA_ADDR`: The ip address of the Kafka brokers. Should be a comma separated list of broker addresses (`ip:port`).
  - `KAFKA_ACK`(*optional*): The level of acknowledgment reliability expected from the Kafka brokers. Valid values are [`NoResponse`, `WaitForLocal`, `WaitForAll`]. Defaults to `WaitForAll`.
  - `KAFKA_CLIENT_ID`(*optional*): The id of the Kafka producer client. Defaults to hostname of the instance.

  More info on the `KafkaOutput` pluging available [here.](http://hekad.readthedocs.io/en/v0.10.0/config/outputs/kafka.html)

Sample usage
============
```
docker run -i -t \
  -e "DATA_DIR=/tmp" \
  -e "FILE_MATCH=\"(?P<FileName>[^/]+).log\"" \
  -e "KAFKA_TOPIC=heka_test1" \
  -e "KAFKA_ADDR=127.0.0.1:9092" \
  -e "KAFKA_ACK=WaitForAll" \
  -e "KAFKA_CLIENT_ID=heka_client_1" \
  --rm segment/heka
```
