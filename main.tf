resource "aws_iam_role" "tile" {
  name               = var.api_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_api_gateway_rest_api" "tile" {
  name               = var.api_name
  description        = "Tile service"
  binary_media_types = var.api_binary_media_types
}

module "bucket" {
  source = "./modules/s3"
  for_each = local.buckets_to_create
  s3_bucket_name = each.value.name
  s3_bucket_policy = local.bucket_policy
}