resource "aws_s3_bucket" "sybil-health-dev-bucket-static" {
  bucket = "sybil-health-dev-bucket-static" # Ensure this is globally unique

  tags = {
    Name = "sybil-health-dev-bucket-static"
  }
}

resource "aws_s3_bucket_website_configuration" "sybil-health-dev-bucket-static_config" {
  bucket = aws_s3_bucket.sybil-health-dev-bucket-static.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html" # Optional but recommended for handling 404 errors
  }
}
