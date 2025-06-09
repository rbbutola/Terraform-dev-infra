variable "aws_region" {
  default = "ap-south-1"
}

# API Gateway REST API
resource "aws_api_gateway_rest_api" "sybil_health_dev_api" {
  name        = "sybil-health-dev-api"
  description = "API Gateway for sybil-health-dev Lambda integration"
}

# API Resource (i.e. /testresource)
resource "aws_api_gateway_resource" "sybil_health_dev_apiresource" {
  rest_api_id = aws_api_gateway_rest_api.sybil_health_dev_api.id
  parent_id   = aws_api_gateway_rest_api.sybil_health_dev_api.root_resource_id
  path_part   = "testresource"
}

# GET Method
resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.sybil_health_dev_api.id
  resource_id   = aws_api_gateway_resource.sybil_health_dev_apiresource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Lambda Integration for API Gateway
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sybil_health_dev_api.id
  resource_id             = aws_api_gateway_resource.sybil_health_dev_apiresource.id
  http_method             = aws_api_gateway_method.get_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.sybil_health_dev_lambda.invoke_arn
}

# Lambda Permission for API Gateway
resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sybil_health_dev_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.sybil_health_dev_api.execution_arn}/*/*"
}

# Deployment Resource
resource "aws_api_gateway_deployment" "apigw_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.sybil_health_dev_api.id
}

# Stage (dev)
resource "aws_api_gateway_stage" "dev" {
  stage_name    = "dev"
  rest_api_id   = aws_api_gateway_rest_api.sybil_health_dev_api.id
  deployment_id = aws_api_gateway_deployment.apigw_deployment.id
  description   = "Dev stage"
}

# Output the invoke URL
output "api_gateway_invoke_url" {
  value = "https://${aws_api_gateway_rest_api.sybil_health_dev_api.id}.execute-api.${var.aws_region}.amazonaws.com/dev/testresource"
}
