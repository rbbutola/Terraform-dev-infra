resource "aws_secretsmanager_secret" "db_secret" {
  name = "sybil-health-dev-env4-dbsecret"
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id

  secret_string = jsonencode({
    host     = "testhost"
    username = "testuser"
    password = "testpasswd"
    port     = 5432
  })
}
