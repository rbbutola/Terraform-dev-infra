# /getobject Resource
resource "aws_api_gateway_resource" "getobject" {
  rest_api_id = aws_api_gateway_rest_api.sybil_health_dev_api.id
  parent_id   = aws_api_gateway_rest_api.sybil_health_dev_api.root_resource_id
  path_part   = "getobject"
}

# GET Method for /getobject
resource "aws_api_gateway_method" "getobject_get" {
  rest_api_id   = aws_api_gateway_rest_api.sybil_health_dev_api.id
  resource_id   = aws_api_gateway_resource.getobject.id
  http_method   = "GET"
  authorization = "NONE"
}

# Lambda Integration
resource "aws_api_gateway_integration" "getobject_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.sybil_health_dev_api.id
  resource_id             = aws_api_gateway_resource.getobject.id
  http_method             = aws_api_gateway_method.getobject_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.sybil_health_dev_lambda.invoke_arn
}
