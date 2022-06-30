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
  s3_bucket_name = var.bucket
}

output "api_invoke_url" {
  description = "Output the invoke URL once the API is deployed."
  value       = module.tile.api_invoke_url
}