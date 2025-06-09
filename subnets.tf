resource "aws_subnet" "sybil-health-pri1" {
  vpc_id                  = aws_vpc.sybil-health-dev-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "sybil-health-pri1"
  }
}

resource "aws_subnet" "sybil-health-pri2" {
  vpc_id                  = aws_vpc.sybil-health-dev-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "sybil-health-pri2"
  }
}

resource "aws_subnet" "sybil-health-pub1" {
  vpc_id                  = aws_vpc.sybil-health-dev-vpc.id
  cidr_block              = "10.0.101.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "sybil-health-pub1"
  }
}

resource "aws_subnet" "sybil-health-pub2" {
  vpc_id                  = aws_vpc.sybil-health-dev-vpc.id
  cidr_block              = "10.0.102.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "sybil-health-pub2"
  }
}

resource "aws_subnet" "sybil-health-pridb1" {
  vpc_id                  = aws_vpc.sybil-health-dev-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "sybil-health-pridb1"
  }
}

resource "aws_subnet" "sybil-health-pridb2" {
  vpc_id                  = aws_vpc.sybil-health-dev-vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "sybil-health-pridb2"
  }
}
