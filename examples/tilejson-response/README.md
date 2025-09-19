# TileJSON Integration Response Template Example

This example extends the [Custom domain name example](../custom-domain/) to rewrite the TileJSON response on-the-fly using an API Gateway Mapping Template.

For example, given the TileJSON below the "<DOMAIN_PREFIX>" value is substitute for the `$context.domainPrefix` variable[^1] after the TileJSON has been returned from S3. This on-the-fly substitution is useful in cases where TileJSON files are shared between different instances of the module.

## Example TileJSON Snippet
```json
{
	"description": "Example",
	"format": "pbf",
	"id": "example",
	"maxzoom": 14,
	"minzoom": 0,
	"name": "example",
	"private": true,
	"scheme": "xyz",
	"tilejson": "2.2.0",
	"tiles": ["https://<DOMAIN_PREFIX>.domain.com/tile/v1/tileset/example/version/{z}/{x}/{y}.pbf"],
	"type": "overlay",
}
```

## Example Module Resource

```hcl
module "tile" {
  source                         = "addresscloud/apigateway-tile-service/aws"
  api_name                       = "tile-service"
  api_region                     = var.region
  s3_bucket_name                 = var.bucket
  api_tilejson_response_template = <<-EOT
  #set( $input.path('$').tiles[0] = $input.path('$').tiles[0].replace("<DOMAIN_PREFIX>", $context.domainPrefix ) )
  $input.json('$')
  EOT
}
```

### References

[^1]: https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-mapping-template-reference.html#context-variable-reference