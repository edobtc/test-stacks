resource "aws_sns_topic" "demo-topic" {
  name = "demo-topic"
}

resource "aws_sqs_queue" "demo-queue" {
  name                      = "demo-queue"
  message_retention_seconds = 604800
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.demo-topic.arn
  endpoint  = aws_sqs_queue.demo-queue.arn
  protocol  = "sqs"
}

resource "aws_sqs_queue_policy" "allow" {
  queue_url = aws_sqs_queue.demo-queue.id

  policy = data.aws_iam_policy_document.sqs-queue-policy.json
}

data "aws_iam_policy_document" "sqs-queue-policy" {
  policy_id = "${aws_sqs_queue.demo-queue.arn}/SQSDefaultPolicy"

  statement {
    sid    = "AllowSNSWrite"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      aws_sqs_queue.demo-queue.arn
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        aws_sns_topic.demo-topic.arn
      ]
    }
  }
}
