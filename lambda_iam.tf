resource "aws_iam_role" "sybil_health_dev_lambda_exec_role" {
  name = "sybil_health_dev_lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sybil_health_dev_lambda_exec_role" {
  role       = aws_iam_role.sybil_health_dev_lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "sybil_health_dev_lambda_vpc_access" {
  role       = aws_iam_role.sybil_health_dev_lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_policy" "sybil_health_dev_lambda_secret_policy" {
  name = "sybil_health_dev_lambda_secret_access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = aws_secretsmanager_secret.db_secret.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sybil_health_dev_lambda_secret_policy_attachment" {
  role       = aws_iam_role.sybil_health_dev_lambda_exec_role.name
  policy_arn = aws_iam_policy.sybil_health_dev_lambda_secret_policy.arn
}

# New: S3 access policy for Lambda to get and put objects in sybil-health-dev-bucket
resource "aws_iam_policy" "sybil_health_dev_lambda_s3_policy" {
  name = "sybil_health_dev_lambda_s3_access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = "arn:aws:s3:::sybil-health-dev-bucket/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sybil_health_dev_lambda_s3_policy_attachment" {
  role       = aws_iam_role.sybil_health_dev_lambda_exec_role.name
  policy_arn = aws_iam_policy.sybil_health_dev_lambda_s3_policy.arn
}
