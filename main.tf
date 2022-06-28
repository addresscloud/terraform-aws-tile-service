resource "aws_iam_role" "tile" {
  name               = "tile"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_s3_bucket" "tile" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_policy" "tile" {
  bucket = aws_s3_bucket.tile.id
  policy = data.aws_iam_policy_document.bucket.json
}

resource "aws_s3_bucket_acl" "tile" {
  bucket = aws_s3_bucket.tile.bucket
  acl    = "private"
}

resource "aws_s3_bucket_cors_configuration" "tile" {
  bucket = aws_s3_bucket.tile.bucket
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["null"]
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tile" {
  bucket = aws_s3_bucket.tile.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tile" {
  bucket                  = aws_s3_bucket.tile.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_api_gateway_rest_api" "tile" {
  name               = "tile"
  description        = "Tile service"
  binary_media_types = ["*/*"]
}
