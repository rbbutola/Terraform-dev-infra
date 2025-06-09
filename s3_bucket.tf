resource "aws_s3_bucket" "sybil-health-dev-bucket" {
  bucket = "sybil-health-dev-bucket" # Make sure this name is globally unique

  tags = {
    Name = "sybil-health-dev-bucket"
  }
}
