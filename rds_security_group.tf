resource "aws_security_group" "sybil_health_dev_database" {
  name        = "sybil_health_dev_database"
  description = "Allow database access"
  vpc_id      = aws_vpc.sybil-health-dev-vpc.id

  ingress {
    description     = "Allow PostgreSQL from Lambda SG"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.sybil-health-dev-vpc-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sybil_health_dev_database"
  }
}
