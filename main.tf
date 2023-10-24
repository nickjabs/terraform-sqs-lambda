provider "aws" {
  region  = var.region
  profile = "Student-967256770327"
}


resource "aws_sqs_queue" "example" {
  name = "example-queue"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-sqs-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "sqs_policy" {
  name = "sqs-access-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "sqs:*",
        Effect   = "Allow",
        Resource = aws_sqs_queue.example.arn
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "sqs_policy_attachment" {
  policy_arn = aws_iam_policy.sqs_policy.arn
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_function" "example_lambda" {
  filename      = "${path.module}/lambda_function.zip"
  function_name = "example_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.example.id
    }
  }
}

resource "aws_sqs_queue_policy" "example_policy" {
  queue_url = aws_sqs_queue.example.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sqs:SendMessage",
        Effect    = "Allow",
        Principal = "*",
        Resource  = aws_sqs_queue.example.arn,
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_lambda_function.example_lambda.arn
          }
        }
      }
    ]
  })
}



