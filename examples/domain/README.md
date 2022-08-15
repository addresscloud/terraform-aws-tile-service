# Custom Domain Name Example

Custom domain names can be configured outside the module, following the [Terraform instructions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_domain_name).

```hcl
module "tile" {
  source                 = "addresscloud/apigateway-tile-service/aws"
  api_name               = "tile-service"
  api_region             = var.region
  s3_bucket_name         = var.bucket
  api_deployment_trigger = "version 1.2.3"
}
```

## Create custom domain

```hcl
resource "aws_api_gateway_domain_name" "tile" {
  certificate_arn = "<CERTIFICATE_ARN>"
  domain_name     = "<DOMAIN_NAME>"
}
```

## Map the stages to the domain

```hcl
resource "aws_api_gateway_base_path_mapping" "tile" {
  api_id      = module.tile.api_id
  stage_name  = "default"
  domain_name = aws_api_gateway_domain_name.tile.domain_name
  depends_on  = [module.tile]
}
```