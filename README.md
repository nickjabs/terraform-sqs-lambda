README

Title: AWS Lambda SQS Example

Description:

This project creates an AWS Lambda function that sends and receives messages from an SQS queue. The Lambda function is triggered when a message is added to the queue.

How to use:

Deploy the project using Terraform.
Add a message to the SQS queue.
The Lambda function will be triggered and will process the message.
To deploy the project using Terraform:

terraform init
terraform apply
To add a message to the SQS queue:

aws sqs send-message --queue-url ${aws_sqs_queue.example.id} --message-body "Hello, world!"
To monitor the Lambda function:

aws logs get-log-events --log-group /aws/lambda/${aws_lambda_function.example_lambda.function_name} --log-stream-name latest

How to apply:

Additional notes:

The Lambda function code is located in the lambda_function.zip file.
The Lambda function is triggered when a message is added to the SQS queue.
The Lambda function will send a message back to the SQS queue after it has processed the message.
The SQS queue is configured to allow messages to be sent from the Lambda function.
The Lambda function is configured to have access to the SQS queue.