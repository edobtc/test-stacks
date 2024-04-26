resource "aws_kinesis_stream" "demo-stream" {
  name             = "demo-stream"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]
}
