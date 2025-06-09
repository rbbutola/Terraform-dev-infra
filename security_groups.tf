resource "aws_security_group" "sybil-health-dev-vpc-sg" {
  name        = "sybil-health-dev-vpc-sg"
  description = "Allow HTTP/HTTPS"
  vpc_id      = aws_vpc.sybil-health-dev-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sybil-health-dev-vpc-sg"
  }
}
