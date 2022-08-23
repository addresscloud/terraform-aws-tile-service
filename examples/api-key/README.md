# API Key Example

This example demonstrates configuration of an API key and usage plan for use with the module. By default the module requires an API key to access all endpoints (configurable with the `api_require_api_key` parameter). Because API key management and usage plan configuration is user specific the module does not create these automatically but instead lets the user manage these outside the module (as shown in here). This example also demonstrates setting the stage name to a custom variable ("dev") instead of the default value ("default") which can be useful when working with different environments.

## Terraform 

The Terraform code in [main.tf](main.tf) creates a usage plan "dev" and an API key "developer-api-key" and links them to the tile API. The output `dev_api_key` is the value that can be included in the `x-api-key` header as shown in the MapLibre section below.

```hcl
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
```

## X-Api-Key

Use the value of `dev_api_key` for API calls to the service, for example:

```http
GET /v1/{tileset}/
X-Api-Key: {API_KEY}
```

## Map Libre Example

You can include the `x-api-key` header in MapLibre by filtering requests made to the API URL (`api_invoke_url`) and including the `dev_api_key` value.

```js
var map = new maplibregl.Map({
    container: 'map',
    style: style,
    center: [-1.737832, 52.814301],
    zoom: 12,
    transformRequest: (url, resourceType) => {
        if (url.startsWith('YOUR_API_INVOKE_URL')) {
            return {
                url,
                headers: { 'x-api-key': 'YOUR_DEV_API_KEY'}
            }
        }
    }
});
```

Further documentation: https://maplibre.org/maplibre-gl-js-docs/api/map/#map-parameters