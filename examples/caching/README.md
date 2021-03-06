# Caching Example

This folder extends the [Quick Start]('../quickstart') example to enable API Gateway caching. Caching is enabled by setting two variables in the module configuration. 

* `api_cache_size` - adding this setting will initialise a dedicated cache cluster in API Gateway.
* `api_cache_ttl` - adding this setting will enable caching for the tile endpoint. Requires `api_cache_size` to be set. Set the ttl between 0 and 3600. Set to 0 to disable caching on the tile endpoint (useful for debugging).

```hcl
module "tile" {
  source            = "addresscloud/apigateway-tile-service/aws"
  api_name          = "tile-service"
  api_region        = "<REGION>"
  s3_bucket_name    = "<BUCKET>"
  api_cache_size    = 0.5
  api_cache_ttl     = 3600
}
```

The TileJSON endpoint (`v1/{tileset}/`) does not have caching enabled, so updates to tileset parameters are published immediately.

The Get tile endpoint (`v1/{tileset}/{z}/{x}/{y}`) will now be cached. Subsequent requests for the same tile will be served from the API Gateway cache and not from S3. Caching will continue until the TTL value is reached or the cache is full.

See [AWS Documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html) for further details on API Gateway caching.
