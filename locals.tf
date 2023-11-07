locals {
  buckets_to_create       = var.s3_skip_creation == true ? {} : { name : var.s3_bucket_name }
  bucket_policy           = var.s3_bucket_policy != "" ? var.s3_bucket_policy : data.aws_iam_policy_document.bucket.json
  bucket_arn              = "arn:aws:s3:::${var.s3_bucket_name}"
  tile_json_uri           = var.tile_json_integration_override != "" ? var.tile_json_integration_override : "arn:aws:apigateway:${var.api_region}:s3:path/${var.s3_bucket_name}/{tileset}/tile.json"
  execution_role_policies = merge(var.api_execution_role_policy_arns, { AmazonAPIGatewayPushToCloudWatchLogs : "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs" })
}
