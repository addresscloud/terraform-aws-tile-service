# API Gateway Tile Service

[![Validate](https://github.com/addresscloud/terraform-aws-tile-service/actions/workflows/validate.yml/badge.svg)](https://github.com/addresscloud/terraform-aws-tile-service/actions/workflows/validate.yml)

This Terraform module provisions a vector tile service using Amazon API Gateway and S3. API requests are mapped to a cache of vector tiles stored in an S3 bucket. The service is completely serverless.

![Service diagram](https://github.com/addresscloud/terraform-aws-tile-service/raw/main/diagram.png)

## Demo

https://addresscloud.github.io/terraform-aws-tile-service/

## Table of Contents

- [About](#about)
- [Install](#install)
- [API](#API)
- [Additional Options](#additional-options)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## About

The module uses Amazon API Gateway and S3 to provision a vector tile API suitable for modern mapping libraries such as [MapLibre](https://maplibre.org/) and [Mapbox](https://www.mapbox.com/).

API Gateway is particularly useful when authorization is required to protect non-public data sources. S3 provides a secure and scaleable storage backend and when used with API Gateway removes the need for any server-side logic or functions. The module's serverless architecture means that the service is highly-scaleable.

This module is maintained by [Addresscloud](https://github.com/addresscloud/).

### Alternatives

These alternatives influenced the design of this module should be considered if API Gateway features are not needed.

- [CloudFront + S3](https://github.com/addresscloud/serverless-tiles) the cheapest way to self-host tiles
- [TiTiler](https://github.com/developmentseed/titiler) supports multiple data types including rasters using Lambda functions
- [MapTiler Cloud](https://www.maptiler.com/cloud/) excellent commercial solution when self-hosting is not required

## Install

Create a Terraform configuration that initialises the module and specifies the values of the variables as shown below. This will create a new S3 bucket and API Gateway instance. For further details see [examples/quickstart](examples/quickstart).

### Terraform

```terraform
provider "aws" {
  region  = "<REGION>"
}

module "tile" {
  source            = "addresscloud/tile-service/aws"
  api_name          = "tile-service"
  api_region        = "<REGION>"
  s3_bucket_name    = "<NEW_BUCKET_NAME>"
}
```

### Vector Tile Requirements

* protocol buffers (`.pbf`)
* gzip content encoding
* [slippy map tilenames specification](https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames)

Both [mb-util](https://github.com/mapbox/mbutil) and [tippecanoe](https://github.com/mapbox/tippecanoe) can create tile caches in this format.

### Bucket layout

Tiles should be stored in the bucket using the layout below.

```
<NEW_BUCKET_NAME>/
  {tileset}/
    tile.json
    {version}/
      {z}/
        {x}/
          {y}.pbf
```
* Where `<NEW_BUCKET_NAME>` is the bucket defined in the `s3_bucket_name` variable.

* The `tileset` is a directory with any unique URI-safe alphanumeric name to identify individual tile sets.

* The `version` is a directory with any unique URI-safe alphanumeric name to differentiate versions of the tile set. For example `2022-06-28`.

* The `tile.json` file should be a [TileJSON](https://github.com/mapbox/tilejson-spec) file describing the tileset and with the `tiles` attribute pointing to the newly created API Gateway instance.

Example complete S3 tile path:

```
s3://<NEW_BUCKET_NAME>/oprvrs/2022-04-01/0/494/347.pbf
```

### Outputs

The module outputs the variable `api_invoke_url` which is the public URL for the API. 

## API

### Endpoints

This module exposes two endpoints:

#### **Get TileJSON**
```http
GET /{api_invoke_url}/v1/{tileset}/
X-Api-Key: {API_KEY}
```

#### **Get a tile**
```http
GET /{api_invoke_url}/v1/{tileset}/{z}/{x}/{y}
X-Api-Key: {API_KEY}
```

Both endpoints support `OPTIONS` requests for CORS. See [examples/lambda-authorizer](examples/lambda-authorizer) for a header configuration example.

### Example MapLibre Implementation

See [examples/quickstart](examples/quickstart).

### Version Path

The module includes a `v1` in the path to future proof against breaking changes to the API.

## Additional Options

### Caching

The module supports caching tile requests using [API Gateway caching](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html). Caching is disabled by default because it incurs an hourly cost not included in the AWS Free Tier. To enable caching add the following parameters to the module configuration. See [examples/caching](examples/caching) for further details.

* `api_cache_size` - adding this setting will initialise a dedicated cache cluster in API Gateway.
* `api_cache_ttl` - adding this setting will enable caching for the tile endpoint. Requires `api_cache_size` to be set. Set the ttl between 0 and 3600. Set to 0 to disable caching on the tile endpoint (useful for debugging). TileJSON requests are never cached.

### Custom Authorization

The module supports reference to a Lambda authorizer function, which is created outside of the module. Custom Access Control headers for CORS can also be configured. See [examples/lambda-authorizer](examples/lambda-authorizer) for a complete example.

### Deployment Trigger

The module supports the `api_deployment_trigger` for fine-grained control of API deployments. Where a deployment trigger isn't specified the module defaults to using a unique timestamp on each terraform run. See [examples/deployment-trigger](examples/deployment-trigger) for details.

### API Key Configuration

The module automatically requires an API Gateway API key to be present in all requests using the `X-API-KEY` header. The example in [examples/api-key](examples/api-key) demonstrates creation of an API key and usage plan using Terraform for use with the API. Alternatively the API key requirement can be completely disabled by setting the `api_require_api_key` variable to `false`. Note that this may expose an API to public access.

### Custom Domain Name

See [examples/domain](examples/domain)

## Maintainers

[@tomasholderness](https://github.com/tomasholderness)

## Contributing

PRs accepted.

## License

MIT © 2022 Addresscloud Limited