terraform {
  backend "local" {}
}

provider "aws" {
  region  = "<REGION>"
}

module "tile" {
  source            = "addresscloud/apigateway-tile-service/aws"
  api_name          = "tile-service"
  api_region        = "<REGION>"
  s3_bucket_name    = "<BUCKET>"
}

output "api_invoke_url" {
    description = "Output the invoke URL once the API is deployed."
    value = module.tile.api_invoke_url
}