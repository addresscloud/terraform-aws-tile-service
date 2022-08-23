terraform {
  backend "local" {}
}

variable "region" {
  description = "Your AWS region."
}

variable "bucket" {
  description = "Your S3 bucket name."
}

variable "certificate_arn" {
  description = "Route53 / DNS certificate ARN."
}

variable "domain_name" {
  description = "Custom domain name."
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

resource "aws_api_gateway_domain_name" "tile" {
  certificate_arn = var.certificate_arn
  domain_name     = var.domain_name
}

resource "aws_api_gateway_base_path_mapping" "tile" {
  api_id      = module.tile.api_id
  stage_name  = "default"
  domain_name = aws_api_gateway_domain_name.tile.domain_name
  depends_on  = [module.tile]
}
