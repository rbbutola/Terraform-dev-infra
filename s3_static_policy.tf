data "aws_iam_policy_document" "sybil_health_dev_bucket_static_policy" {
  statement {
    actions = ["s3:GetObject"]

    resources = [
      "${aws_s3_bucket.sybil-health-dev-bucket-static.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.sybil-health-dev-bucket-static_distribution.arn] # Update this if your CF distribution resource name differs
    }
  }
}

resource "aws_s3_bucket_policy" "sybil_health_dev_bucket_static_policy" {
  bucket = aws_s3_bucket.sybil-health-dev-bucket-static.id
  policy = data.aws_iam_policy_document.sybil_health_dev_bucket_static_policy.json
}
