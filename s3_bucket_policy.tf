resource "aws_s3_bucket_policy" "sybil-health-dev-bucket-policy" {
  bucket = aws_s3_bucket.sybil-health-dev-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.sybil_health_dev_oac_doc.id}"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.sybil-health-dev-bucket.arn}/*"
      }
    ]
  })
}
