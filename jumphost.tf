# Fetch latest Amazon Linux 2 AMI dynamically
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "sybil_health_dev_jumphost" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.sybil-health-pub1.id                     # Reference your public subnet resource here
  vpc_security_group_ids = [aws_security_group.sybil-health-dev-jumphostsg.id] # Reference correct SG, or use your jumphostsg
  key_name               = "testjumphsotkey"                                   # Confirm this key exists in AWS EC2 KeyPairs

  tags = {
    Name = "sybil-health-dev-jumphost"
  }
}
