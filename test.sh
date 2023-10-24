#!/bin/bash

# Define variables
QUEUE_URL="https://sqs.eu-central-1.amazonaws.com/967256770327/example-queue"  

# Test sending messages to the SQS queue
for i in {1..10}
do
  aws sqs send-message \
    --profile Student-967256770327 \
    --queue-url $QUEUE_URL \
    --message-body "Test $i"
done


exit 0
