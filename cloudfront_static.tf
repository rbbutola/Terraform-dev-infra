resource "aws_cloudfront_origin_access_control" "sybil-health-dev-bucket-static_oac" {
  name                              = "sybil-health-dev-bucket-static_oac"
  description                       = "OAC for sybil-health-dev-bucket-static"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "sybil-health-dev-bucket-static_distribution" {
  origin {
    domain_name              = aws_s3_bucket.sybil-health-dev-bucket-static.bucket_regional_domain_name
    origin_id                = "sybil_health_dev_static"
    origin_access_control_id = aws_cloudfront_origin_access_control.sybil-health-dev-bucket-static_oac.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "sybil_health_dev_static"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = "sybil-health-dev-bucket-static-distribution"
  }
}
