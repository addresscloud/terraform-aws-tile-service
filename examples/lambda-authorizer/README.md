# Lambda Authorizer Example

API Gateway supports Lambda authorizer functions to control access to the tile service using custom authorization logic. This example assumes that a Lambda authorizer has already be created which is referenced in the configuration. See the [AWS documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-use-lambda-authorizer.html) for more details on creating Lambda authorizers.

## Lambda Authorizer Setup

This example uses the `data` block to reference an existing function in the same account and region as the tile API Gateway instance. The `identity_source` parameter sets the header value to be used. An `aws_lambda_permission` block is used to grant API Gateway permission to execute the function.

```terraform
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
```

## Module Setup

Once the authorizer and permissions have been confgured, the module can be set to include the additional header for the identity source.

```terraform
module "tile" {
  source                    = "addresscloud/tile-service/aws"
  api_custom_authorizer_arn = aws_api_gateway_authorizer.demoAuth.id
  api_name                  = "tile-service"
  api_region                = var.region
  s3_bucket_name            = var.bucket
  api_access_control_allow_headers = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,x-amz-meta-fileinfo,x-secret-value'"
}

output "api_invoke_url" {
  description = "Output the invoke URL once the API is deployed."
  value       = module.tile.api_invoke_url
}
```terraform