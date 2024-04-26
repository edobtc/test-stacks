output "queue_url" {
  value = aws_sqs_queue.demo-queue.id
}

output "topic_arn" {
  value = aws_sns_topic.demo-topic.arn
}

output "stream_arn" {
  value = aws_kinesis_stream.demo-stream.arn
}
