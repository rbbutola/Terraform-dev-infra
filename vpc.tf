resource "aws_vpc" "sybil-health-dev-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "sybil-health-dev-vpc"
  }
}

resource "aws_internet_gateway" "sybil-health-dev-igw" {
  vpc_id = aws_vpc.sybil-health-dev-vpc.id
  tags = {
    Name = "sybil-health-dev-igw"
  }
}

resource "aws_eip" "sybil-health-devnetgateway_eip" {
  domain = "vpc" # Changed from deprecated 'vpc = true' to 'domain = "vpc"'
  tags = {
    Name = "sybil-health-devnetgateway-eip"
  }
}

resource "aws_nat_gateway" "sybil-health-devnetgateway" {
  allocation_id = aws_eip.sybil-health-devnetgateway_eip.id
  subnet_id     = aws_subnet.sybil-health-pub1.id
  depends_on    = [aws_internet_gateway.sybil-health-dev-igw]
  tags = {
    Name = "sybil-health-devnetgateway"
  }
}
