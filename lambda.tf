resource "aws_lambda_function" "sybil_health_dev_lambda" {
  function_name = "sybil_health_dev_lambda"
  role          = aws_iam_role.sybil_health_dev_lambda_exec_role.arn
  runtime       = "nodejs18.x"
  handler       = "lambda_function.handler"

  vpc_config {
    subnet_ids = [
      aws_subnet.sybil-health-pri1.id,
      aws_subnet.sybil-health-pri2.id,
    ]
    security_group_ids = [
      aws_security_group.sybil-health-dev-vpc-sg.id
    ]
  }

  publish = false  # prevents unnecessary versioning

  tags = {
    Name = "sybil-health-dev-lambda"
  }

  depends_on = [
    aws_iam_role.sybil_health_dev_lambda_exec_role,
    aws_security_group.sybil-health-dev-vpc-sg
  ]
}
