output "queue_url" {
  description = "URL of the created SQS queue"
  value       = aws_sqs_queue.example.id
}
