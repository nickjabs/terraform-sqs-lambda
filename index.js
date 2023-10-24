// index.js
exports.handler = async (event, context) => {
    const AWS = require('aws-sdk');
    const sqs = new AWS.SQS();
  
    const params = {
      QueueUrl: process.env.QUEUE_URL,
      MessageBody: event.Records[0].body,
    };
  
    try {
      await sqs.sendMessage(params).promise();
      return 'Message sent to the queue.';
    } catch (error) {
      return `Error sending message to the queue: ${error.message}`;
    }
  };
  