# Fetch RDS credentials from Secrets Manager
data "aws_secretsmanager_secret" "rds_secret" {
  name = "sybil-health-dev-master-dbsecret"
}

data "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = data.aws_secretsmanager_secret.rds_secret.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)
}

# DB Subnet Group using private DB subnets
resource "aws_db_subnet_group" "sybil_health_dev_rds_subnet_group" {
  name = "sybil_health_dev_rds_subnet_group"
  subnet_ids = [
    aws_subnet.sybil-health-pridb1.id,
    aws_subnet.sybil-health-pridb2.id
  ]

  tags = {
    Name = "sybil_health_dev_rds_subnet_group"
  }
}

# PostgreSQL RDS instance
resource "aws_db_instance" "sybil-health-dev-database" {
  identifier                     = "sybil-health-dev-database"
  engine                         = "postgres"
  engine_version                 = "17.4"
  instance_class                 = "db.t3.medium"
  allocated_storage              = 30
  storage_type                   = "gp2"
  db_name                        = "sybilhealthdevdb"
  username                       = local.db_credentials.username
  password                       = local.db_credentials.password
  db_subnet_group_name           = aws_db_subnet_group.sybil_health_dev_rds_subnet_group.name
  vpc_security_group_ids         = [aws_security_group.sybil_health_dev_database.id]
  parameter_group_name           = aws_db_parameter_group.sybil_health_dev_rds_parameter_group.name
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  skip_final_snapshot            = true
  publicly_accessible            = false
#  multi_az                      = false
  backup_retention_period        = 14
  auto_minor_version_upgrade     = false
#  deletion_protection           = true
  storage_encrypted              = true
  apply_immediately              = true
  tags = {
    Name = "sybil-health-dev-database"
  }
}
