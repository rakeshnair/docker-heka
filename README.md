Heka
====

Dockerfile for [https://hekad.readthedocs.io/en/v0.10.0/](Heka) version `v0.10.0`.

This Docker image has been pre-configured to read events from an input file, using the [http://hekad.readthedocs.io/en/v0.10.0/config/inputs/logstreamer.html](`LogstreamerInput`) plugin and send them to Kafka using the [https://hekad.readthedocs.io/en/v0.10.0/config/outputs/kafka.html](`KafkaOutput`) plugin.

Environment variables
=====================
The following environment variables should be set for the Heka container to run:
- Environment variables required for the `LogstreamerInput` plugin:
  - `DATA_DIR`: The local file system directory, containing files that should be tailed by Heka. 
  - `FILE_MATCH`: Regular expression used to match files located under the `DATA_DIR`.
  More info on the `LogstreamerInput` plugin available [http://hekad.readthedocs.io/en/v0.10.0/config/inputs/logstreamer.html](here).
- Environment variables required for the `KafkaOutput` plugin:
  - `KAFKA_TOPIC` : The Kafka topic to which events will be published.
  - `KAFKA_ADDR`: The ip address of the Kafka brokers. Should be a comma separated list of broker addresses (`ip:port`).
  - `KAFKA_ACK`(__optional__): The level of acknowledgment reliability expected from the Kafka brokers. Valid values are [`NoResponse`, `WaitForLocal`, `WaitForAll`]. Defaults to `WaitForAll`.
  - `KAFKA_CLIENT_ID`(__optional__): The id of the Kafka producer client. Defaults to hostname of the instance.
  More info on the `KafkaOutput` pluging available [http://hekad.readthedocs.io/en/v0.10.0/config/outputs/kafka.html](here)

Sample usage
============
```
docker run -i -t \
  -e "DATA_DIR=/tmp" \
  -e "FILE_MATCH=\"(?P<FileName>[^/]+).log\"" \
  -e "KAFKA_TOPIC"=heka_test1 \
  -e "KAFKA_ADDR=127.0.0.1:9092" \
  -e "KAFKA_ACK=WaitForAll" \
  -e "KAFKA_CLIENT_ID=heka_client_1" \
  --rm segment/heka
```
