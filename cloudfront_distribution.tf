resource "aws_cloudfront_origin_access_identity" "sybil_health_dev_oac" {
  comment = "OAI for sybil-health-dev S3 access"
}

resource "aws_cloudfront_distribution" "sybil_health_dev_distribution" {
  origin {
    domain_name = aws_s3_bucket.sybil-health-dev-bucket.bucket_regional_domain_name
    origin_id   = "sybil-health-dev-bucketOrigin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.sybil_health_dev_oac.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "sybil-health-dev-bucketOrigin"

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = "sybil-health-dev-bucket-cloudfront"
  }
}
