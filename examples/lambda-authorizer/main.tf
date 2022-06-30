terraform {
  backend "local" {}
}

variable "region" {
  description = "Your AWS region."
}

variable "bucket" {
  description = "Your S3 bucket name."
}

provider "aws" {
  region = var.region
}

data "aws_lambda_function" "authorizer" {
  function_name = "demoCustomAuthorizer"
}

resource "aws_api_gateway_authorizer" "demoAuth" {
  name                             = "demo-auth"
  rest_api_id                      = module.tile.api_id
  authorizer_uri                   = data.aws_lambda_function.authorizer.invoke_arn
  authorizer_result_ttl_in_seconds = 300
  type                             = "REQUEST"
  identity_source                  = "method.request.header.x-secret-value"
}

resource "aws_lambda_permission" "demoAuth" {
  statement_id  = "AllowExecutionFromAPIGW"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.authorizer.function_name
  principal     = "apigateway.amazonaws.com"
}

module "tile" {
  source                           = "addresscloud/tile-service/aws"
  api_custom_authorizer_arn        = aws_api_gateway_authorizer.demoAuth.id
  api_name                         = "tile-service"
  api_region                       = var.region
  s3_bucket_name                   = var.bucket
  api_access_control_allow_headers = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,x-amz-meta-fileinfo,x-secret-value'"
  api_access_control_origin        = "'<DOMAIN>'"
}

output "api_invoke_url" {
  description = "Output the invoke URL once the API is deployed."
  value       = module.tile.api_invoke_url
}