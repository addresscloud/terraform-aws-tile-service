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

module "tile" {
  source         = "addresscloud/apigateway-tile-service/aws"
  api_name       = "tile-service"
  api_region     = var.region
  api_stage_name = "dev"
  s3_bucket_name = var.bucket
}

resource "aws_api_gateway_usage_plan" "dev" {
  name        = "dev"
  description = "Dev usage plan"

  api_stages {
    api_id = module.tile.api_id
    stage  = "dev"
  }

  throttle_settings {
    burst_limit = 5
    rate_limit  = 10
  }
}

resource "aws_api_gateway_api_key" "dev" {
  name = "developer-api-key"
}

resource "aws_api_gateway_usage_plan_key" "dev" {
  key_id        = aws_api_gateway_api_key.dev.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.dev.id
}

output "api_invoke_url" {
  description = "Output the invoke URL once the API is deployed."
  value       = module.tile.api_invoke_url
}

output "dev_api_key" {
  description = "Output API key for the dev usage plan."
  value       = aws_api_gateway_api_key.dev.value
}