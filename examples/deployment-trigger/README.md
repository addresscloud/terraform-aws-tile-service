# Custom API Gateway Deployment Trigger

Changes to API Gateway must be followed by an API deployment for them to be reflected in the service. By default this module forces a redeployment for every `apply` by using the current timestamp as a trigger variable. This example demonstrates alternatives.

## Hardcoded Parameter

Useful for manual control of deployments. The value must be changed to trigger deployments. 

```terraform
module "tile" {
  source                 = "addresscloud/apigateway-tile-service/aws"
  api_name               = "tile-service"
  api_region             = var.region
  s3_bucket_name         = var.bucket
  api_deployment_trigger = "version 1.2.3"
}
```

## File Hash

This approach avoids hardcoding a value, but only trigggers a build when the relevant Terraform file has been changed. A complete worked example is included in [main.tf](main.tf)

```terraform
module "tile" {
  source                 = "addresscloud/apigateway-tile-service/aws"
  api_name               = "tile-service"
  api_region             = var.region
  s3_bucket_name         = var.bucket
  api_deployment_trigger = filesha256("main.tf")
}
```

