output "sybil-health-dev-vpc" {
  value = aws_vpc.sybil-health-dev-vpc.id
}

output "sybil-health-pub1_subnet" {
  value = aws_subnet.sybil-health-pub1.id
}

output "sybil-health-pri1_subnet" {
  value = aws_subnet.sybil-health-pri1.id
}

output "sybil-health-devnetgateway" {
  value = aws_nat_gateway.sybil-health-devnetgateway.id
}

output "sybil-health-dev-vpc-sg" {
  value = aws_security_group.sybil-health-dev-vpc-sg.id
}
