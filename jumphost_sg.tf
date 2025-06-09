resource "aws_security_group" "sybil-health-dev-jumphostsg" {
  name        = "sybil-health-dev-jumphostsg"
  description = "Security group for jump host"
  vpc_id      = aws_vpc.sybil-health-dev-vpc.id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Replace below with your trusted IP or office range for security best practice
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sybil-health-dev-jumphostsg"
  }
}
