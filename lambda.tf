resource "aws_lambda_function" "sybil_health_dev_lambda" {
  function_name    = "sybil_health_dev_lambda"
  handler          = "lambda_function.handler"
  runtime          = "nodejs18.x"
  role             = aws_iam_role.sybil_health_dev_lambda_exec_role.arn
  filename         = "${path.module}/sybil-health-dev-lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/sybil-health-dev-lambda.zip")

  vpc_config {
    subnet_ids = [
      aws_subnet.sybil-health-pri1.id,
      aws_subnet.sybil-health-pri2.id,
    ]
    security_group_ids = [
      aws_security_group.sybil-health-dev-vpc-sg.id
    ]
  }

  tags = {
    Name = "sybil-health-dev-lambda"
  }

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash
    ]
  }

  depends_on = [
    aws_iam_role.sybil_health_dev_lambda_exec_role,
    aws_security_group.sybil-health-dev-vpc-sg
  ]
}
