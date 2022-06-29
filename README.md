# API Gateway Tile Service

This is a Terraform module for provisioning a vector tile service using Amazon API Gateway and Amazon S3. This module will provide a fully functional vector tile service which is scaleable, highly available and fault-tolerant. The service works by mapping API requests to a cache of vector tiles stored in the S3 bucket.

## About This Module

This module uses Amazon API Gateway and S3 to provision a RESTFul vector tile API suitable for consumption using modern mapping applications such as [MapLibre](https://maplibre.org/) and [Mapbox](https://www.mapbox.com/). API Gateway is particularly useful when advanced authorization configuration is required to protect non-public data sources. S3 provides a secure and scaleable storage backend and when used with API Gateway removes the need for any server-side logic or functions. This module is maintained by [Addresscloud]().

## How To Use This Module

Create a Terraform configuration that initialises the module and specifies the values of the variables as shown below. This will create a new S3 bucket and API Gateway instance. For more advanced examples see the [examples/]() folder.

### Quick Start

```terraform
provider "aws" {
  region  = "<REGION>"
}

module "tile" {
  source            = "../modules/tile/"
  api_name          = "tile-service"
  api_region        = "<REGION>"
  s3_bucket_name    = "<NEW_BUCKET_NAME>"
}
```

### Vector Tile Requirements

Vector tiles should be `.pbf` (protocol buffers) files with `gzip` content encoding stored in the Slippy Map Tilenames [specification](https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames) (`{z}/{x}/{y}.pbf`) in the tileset directory. Both [mb-util](https://github.com/mapbox/mbutil) and [tippecanoe](https://github.com/mapbox/tippecanoe) can create tile caches in this format.

### Bucket layout

Tiles should be stored in the bucket using the layout below.

```
<NEW_BUCKET_NAME>/
  {tileset}/
    tiles.json
    {version}/
      {z}/
        {x}/
          {y}.pbf
```
* Where `<NEW_BUCKET_NAME>` is the bucket defined in the `s3_bucket_name` variable.

* The `tileset` is a directory with any unique URI-safe alphanumeric name to identify individual tile sets. For example `oprvrs` for the Ordnance Survey's Open Rivers tileset show in the [demo]().

* The `version` is a directory with any unique URI-safe alphanumeric name to differentiate versions of the tile set. For example `2022-06-28`.

* The `tiles.json` file should be a [TileJSON](https://github.com/mapbox/tilejson-spec) file describing the tileset.

Example complete S3 tile path:

```
s3://<NEW_BUCKET_NAME>/oprvrs/2022-04-01/0/494/347.pbf
```

## API

### Endpoints

This module exposes two endpoints:

#### **Get TileJSON**
```http
GET /v1/{tileset}/
X-Api-Key: {API_KEY}
```

#### **Get a tile**
```http
GET /v1/{tileset}/{z}/{x}/{y}
X-Api-Key: {API_KEY}
```

Both endpoints support `OPTIONS` requests for CORS. See [examples]() for header configuration.

### Example MapLibre Implementation

// TODO

## Advanced Usage

### Caching

This module supports caching tile requests using [API Gateway caching](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html). Caching is disabled by default because it incurs an hourly cost not included in the AWS Free Tier. To enable caching add the following parameters to the module configuration. See [examples/caching]('../examples/caching) for a complete example.

* `api_cache_size` - adding this setting will initialise a dedicated cache cluster in API Gateway.
* `api_cache_ttl` - adding this setting will enable caching for the tile endpoint. Requires `api_cache_size` to be set. Set the ttl between 0 and 3600. Set to 0 to disable caching on the tile endpoint (useful for debugging). TileJSON requests are never cached.

### Custom Authorisation

The module supports reference to an authorizer (Lambda) function, which is created outside of the module. Custom Access Control headers for CORS can also be configured. See [examples/]() for a complete example.

### Deployment Trigger

// TODO

### API Key Configuration

The module automatically requires an API Gateway API key to be present in all requests using the `X-API-KEY` header. The example in [examples/]() demonstrates creation of an API key and usage plan using Terraform for use with the API. Alternatively the API key requirement can be completely disabled by setting the `api_require_api_key` variable to `false`. Note that this may expose an API to public access.

### Custom Domain Name

// TODO