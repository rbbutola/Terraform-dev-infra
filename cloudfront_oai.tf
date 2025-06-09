resource "aws_cloudfront_origin_access_identity" "sybil_health_dev_oac_static" {
  comment = "OAI for sybil-health-dev-bucket-static"
}

resource "aws_cloudfront_origin_access_identity" "sybil_health_dev_oac_doc" {
  comment = "OAI for sybil-health-dev-bucket"
}
