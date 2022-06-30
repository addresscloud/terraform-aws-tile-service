# Custom Domain Name Example

TODO.

# Create custom domain
resource "aws_api_gateway_domain_name" "tile" {
  certificate_arn = "<CERTIFICATE_ARN>"
  domain_name     = "<DOMAIN_NAME>"
}

# Map the stages to the domain
resource "aws_api_gateway_base_path_mapping" "tile" {
  api_id      = module.tile.api_id
  stage_name  = "default"
  domain_name = aws_api_gateway_domain_name.tile.domain_name
  depends_on  = [module.tile]
}