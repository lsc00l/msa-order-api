#!/bin/bash

# 카프카 대기
echo "Waiting for Kafka to be ready..."
sleep 30

# 토픽 생성
echo "Creating Kafka topics..."
docker-compose exec -T kafka /opt/bitnami/kafka/bin/kafka-topics.sh \
    --create \
    --if-not-exists \
    --bootstrap-server kafka:29092 \
    --topic order-event \
    --partitions 3 \
    --replication-factor 1

# 토픽 생성 확인
echo "Verifying topics..."
docker-compose exec -T kafka /opt/bitnami/kafka/bin/kafka-topics.sh \
    --list \
    --bootstrap-server kafka:29092