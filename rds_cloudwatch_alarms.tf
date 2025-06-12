# SNS Topic
resource "aws_sns_topic" "sybil_health_nonprod" {
  name = "sybil_health_nonprod"
}

# SNS Email Subscription
resource "aws_sns_topic_subscription" "sybil_health_nonprod_email" {
  topic_arn = aws_sns_topic.sybil_health_nonprod.arn
  protocol  = "email"
  endpoint  = "rbbutolabutola@gmail.com"
}

# CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "sybil_health_dev_rds_high_connections" {
  alarm_name          = "sybil_health_dev_rds_high_connections"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Maximum"
  threshold           = 50
  alarm_description   = "Database connections exceed 50"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.sybil-health-dev-database.id
  }
  treat_missing_data = "breaching"
  alarm_actions      = [aws_sns_topic.sybil_health_nonprod.arn]
}

resource "aws_cloudwatch_metric_alarm" "sybil_health_dev_rds_high_cpu" {
  alarm_name          = "sybil_health_dev_rds_high_cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Maximum"
  threshold           = 70
  alarm_description   = "RDS CPU utilization exceeds 70% for 5 minutes"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.sybil-health-dev-database.id
  }
  treat_missing_data = "breaching"
  alarm_actions      = [aws_sns_topic.sybil_health_nonprod.arn]
}

resource "aws_cloudwatch_metric_alarm" "sybil_health_dev_rds_low_memory" {
  alarm_name          = "sybil_health_dev_rds_low_memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Minimum"
  threshold           = 2147483648  # 2 GB
  alarm_description   = "Freeable memory is less than 2 GB"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.sybil-health-dev-database.id
  }
  treat_missing_data = "breaching"
  alarm_actions      = [aws_sns_topic.sybil_health_nonprod.arn]
}

resource "aws_cloudwatch_metric_alarm" "sybil_health_dev_rds_low_storage" {
  alarm_name          = "sybil_health_dev_rds_low_storage_space"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Minimum"
  threshold           = 26843545600  # 25 GB
  alarm_description   = "Available storage space is less than 25 GB"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.sybil-health-dev-database.id
  }
  treat_missing_data = "breaching"
  alarm_actions      = [aws_sns_topic.sybil_health_nonprod.arn]
}

resource "aws_cloudwatch_metric_alarm" "sybil_health_dev_rds_high_read_iops" {
  alarm_name          = "sybil_health_dev_rds_high_read_iops"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ReadIOPS"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Maximum"
  threshold           = 1000
  alarm_description   = "Read IOPS exceed 1000"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.sybil-health-dev-database.id
  }
  treat_missing_data = "breaching"
  alarm_actions      = [aws_sns_topic.sybil_health_nonprod.arn]
}

resource "aws_cloudwatch_metric_alarm" "sybil_health_dev_rds_high_write_iops" {
  alarm_name          = "sybil_health_dev_rds_high_write_iops"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "WriteIOPS"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Maximum"
  threshold           = 1000
  alarm_description   = "Write IOPS exceed 1000"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.sybil-health-dev-database.id
  }
  treat_missing_data = "breaching"
  alarm_actions      = [aws_sns_topic.sybil_health_nonprod.arn]
}
