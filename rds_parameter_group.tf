resource "aws_db_parameter_group" "sybil_health_dev_rds_parameter_group" {
  name        = "sybil-health-dev-rds-parameter-group"
  family      = "postgres17"
  description = "PostgreSQL parameter group with slow query logging enabled"

  parameter {
    name  = "log_statement"
    value = "ddl"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_error_verbosity"
    value = "default"
  }
}
