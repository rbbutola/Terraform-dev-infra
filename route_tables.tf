# -------------------------------
# Public Route Table
# -------------------------------
resource "aws_route_table" "sybil-health-dev-pubroutetable" {
  vpc_id = aws_vpc.sybil-health-dev-vpc.id
  tags = {
    Name = "sybil-health-dev-pubroutetable"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.sybil-health-dev-pubroutetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sybil-health-dev-igw.id
}

# Associate Public Subnets
resource "aws_route_table_association" "pub1" {
  subnet_id      = aws_subnet.sybil-health-pub1.id
  route_table_id = aws_route_table.sybil-health-dev-pubroutetable.id
}

resource "aws_route_table_association" "pub2" {
  subnet_id      = aws_subnet.sybil-health-pub2.id
  route_table_id = aws_route_table.sybil-health-dev-pubroutetable.id
}

# -------------------------------
# Private Route Table
# -------------------------------
resource "aws_route_table" "sybil-health-dev-priroutetable" {
  vpc_id = aws_vpc.sybil-health-dev-vpc.id
  tags = {
    Name = "sybil-health-dev-priroutetable"
  }
}

resource "aws_route" "private_nat_access" {
  route_table_id         = aws_route_table.sybil-health-dev-priroutetable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.sybil-health-devnetgateway.id
}

# Associate Private Subnets
resource "aws_route_table_association" "pri1" {
  subnet_id      = aws_subnet.sybil-health-pri1.id
  route_table_id = aws_route_table.sybil-health-dev-priroutetable.id
}

resource "aws_route_table_association" "pri2" {
  subnet_id      = aws_subnet.sybil-health-pri2.id
  route_table_id = aws_route_table.sybil-health-dev-priroutetable.id
}

resource "aws_route_table_association" "pridb1" {
  subnet_id      = aws_subnet.sybil-health-pridb1.id
  route_table_id = aws_route_table.sybil-health-dev-priroutetable.id
}

resource "aws_route_table_association" "pridb2" {
  subnet_id      = aws_subnet.sybil-health-pridb2.id
  route_table_id = aws_route_table.sybil-health-dev-priroutetable.id
}
