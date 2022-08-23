# API Gateway Tile Service

[![Validate](https://github.com/addresscloud/terraform-aws-tile-service/actions/workflows/validate.yml/badge.svg)](https://github.com/addresscloud/terraform-aws-tile-service/actions/workflows/validate.yml)

This Terraform module provisions a vector tile service using Amazon API Gateway and S3. API requests are mapped to a cache of vector tiles stored in an S3 bucket. The service is completely serverless.

![Service diagram](https://github.com/addresscloud/terraform-aws-tile-service/raw/main/_img/diagram-v2.png)

## Demo

https://addresscloud.github.io/terraform-aws-tile-service

## Usage

Create S3 bucket and API gateway instance.

```hcl
provider "aws" {
  region  = "YOUR_REGION"
}

module "tile" {
  source            = "addresscloud/tile-service/aws"
  api_name          = "tile-service"
  api_region        = "YOUR_REGION"
  s3_bucket_name    = "YOUR_NEW_BUCKET_NAME"
}

output "api_invoke_url" {
  description = "Output the invoke URL once the API is deployed."
  value       = module.tile.api_invoke_url
}
```

### Vector Tile Requirements

* protocol buffers (`.pbf`)
* gzip content encoding
* slippy map tilenames [specification](https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames)

Both [mb-util](https://github.com/mapbox/mbutil) and [tippecanoe](https://github.com/mapbox/tippecanoe) can create tile caches in this format.

### Bucket layout

Tiles should be stored in the bucket using the layout below.

```
YOUR_NEW_BUCKET_NAME/
  {tileset}/
    tile.json
    {version}/
      {z}/
        {x}/
          {y}.pbf
```
* Where `YOUR_NEW_BUCKET_NAME` is the bucket defined in the `s3_bucket_name` variable.

* The `tileset` is a directory with any unique URI-safe alphanumeric name to identify individual tile sets.

* The `version` is a directory with any unique URI-safe alphanumeric name to differentiate versions of the tile set. For example `2022-06-28`.

* The `tile.json` file should be a [TileJSON](https://github.com/mapbox/tilejson-spec) file describing the tileset and with the `tiles` attribute pointing to the newly created API Gateway instance.

Example complete S3 tile path:

```
s3://YOUR_NEW_BUCKET_NAME/oprvrs/2022-04-01/0/494/347.pbf
```

### API

The API exposes two endpoints:

#### **Get TileJSON**
```http
GET /{APPI_INVOKE_URL}/v1/{tileset}/
X-Api-Key: {API_KEY}
```

#### **Get a tile**
```http
GET /{API_INVOKE_URL}/v1/{tileset}/{z}/{x}/{y}
X-Api-Key: {API_KEY}
```

Both endpoints support `OPTIONS` requests for CORS. See [examples/lambda-authorizer](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/lambda-authorizer) for an example of custom header configuration.

The module automatically requires an API Gateway API key to be present in all requests using the `X-API-KEY` header. The example in [examples/api-key](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/api-key) demonstrates creation of an API key and usage plan. Alternatively the API key requirement can be completely disabled by setting the `api_require_api_key` variable to `false`. Note that this may expose an API to public access.

### Version Path

The module includes a `v1` in the path to future proof against breaking changes to the API.

## Examples

- [api key configuration](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/api-key)
- [caching](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/caching)
- [custom domain name](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/custom-domain)
- [deployment trigger](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/deployment-trigger)
- [lambda authorization](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/lambda-authorizer)

## About

The module uses Amazon API Gateway and S3 to provision a vector tile API suitable for modern mapping libraries such as [MapLibre](https://maplibre.org/) and [Mapbox](https://www.mapbox.com/).

API Gateway is particularly useful when authorization is required to protect non-public data sources. S3 provides a secure and scaleable storage backend and when used with API Gateway removes the need for any server-side logic or functions. The module's serverless architecture means that the service is highly-scaleable.

This module is maintained by [Addresscloud](https://github.com/addresscloud/).

### Alternatives

These alternatives influenced the design of this module should be considered if API Gateway features are not needed.

- [CloudFront + S3](https://github.com/addresscloud/serverless-tiles) the cheapest way to self-host tiles
- [TiTiler](https://github.com/developmentseed/titiler) supports multiple data types including rasters using Lambda functions
- [MapTiler Cloud](https://www.maptiler.com/cloud/) excellent commercial solution when self-hosting is not required

### Maintainers

[@tomasholderness](https://github.com/tomasholderness)

### Contributing

PRs accepted.

### License

MIT © 2022 Addresscloud Limited