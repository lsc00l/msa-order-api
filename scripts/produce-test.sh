#!/bin/bash

# Kafka 브로커 주소
KAFKA_BROKER="localhost:9092"

# 토픽 이름
TOPIC_NAME="order-event"

# 테스트 메시지
MESSAGE='{
    "orderId": 1,
    "userId": "user123",
    "status": "CREATED",
}'

echo "Sending test message to topic: $TOPIC_NAME"
echo $MESSAGE | docker-compose exec -T kafka /opt/bitnami/kafka/bin/kafka-console-producer.sh \
    --bootstrap-server $KAFKA_BROKER \
    --topic $TOPIC_NAME