data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "apigateway.amazonaws.com",
        "logs.${var.api_region}.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "bucket" {
  statement {
    sid = "AccessBucket"
    actions = [
      "s3:ListBucket",
      "s3:GetObject"
    ]
    principals {
      type = "AWS"
      identifiers = [
        aws_iam_role.tile.arn
      ]
    }
    resources = [
      local.bucket_arn,
      "${local.bucket_arn}/*"
    ]
  }
  statement {
    sid     = "AllowSSLRequestsOnly"
    actions = ["s3:*"]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
    effect = "Deny"
    resources = [
      local.bucket_arn,
      "${local.bucket_arn}/*"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}