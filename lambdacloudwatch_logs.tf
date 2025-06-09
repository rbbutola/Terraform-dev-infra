resource "aws_cloudwatch_log_group" "sybil_health_dev_lambda_log_group" {
  name              = "/aws/lambda/sybil_health_dev_lambda"
  retention_in_days = 14

  tags = {
    Name = "sybil_health_dev_lambda-logs"
  }
}
