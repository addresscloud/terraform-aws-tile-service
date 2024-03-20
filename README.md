# API Gateway Tile Service

[![Validate](https://github.com/addresscloud/terraform-aws-tile-service/actions/workflows/validate.yml/badge.svg)](https://github.com/addresscloud/terraform-aws-tile-service/actions/workflows/validate.yml)

This Terraform module provisions a tile service using Amazon API Gateway and S3. The service supports requests against tilesets using the slippy map tiles specification and single-file "tilefile" archives like COGs and PMTiles using range requets. The service is completely serverless.

![Service diagram](https://github.com/addresscloud/terraform-aws-tile-service/raw/main/_img/diagram-v3.png)

## Table of Contents

* [Install](#install)
* [Data Requirements](#data-requirements)
* [API](#api)
* [Client Demos](#client-demos)
* [Configuration Examples](#configuration-examples)
* [About](#about)

## Install

Create a Terraform configuration to setup the module.

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

Run the configuration to create the S3 bucket and API gateway.

```shell
terraform init
terraform apply
```

## Data Requirements

### Tilesets and Tilefiles

The module supports raster and vector [tilesets](https://docs.mapbox.com/help/glossary/tileset/) using the slippy map tilenames [specification](https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames). [TileJSON](https://github.com/mapbox/tilejson-spec) files are also supported using the convention `tile.json` and placed in the root of the tileset (see [Bucket Layout](#bucket-layout)).

The module supports querying raster and vector tilefiles using HTTP range requests. Examples that have been tested are [Cloud Optimised Geotiffs](https://www.cogeo.org/) and [PMTiles](https://github.com/protomaps/PMTiles), examples of both are included in the [Client Demos](#client-demos).

### Bucket Layout

Tiles should be stored in the bucket using the layout below.

```
YOUR_NEW_BUCKET_NAME/
  {tileset}/
    tile.json
    {version}/
      {z}/
        {x}/
          {y.extension}
  {tilefile}/
    {version}/
      {file.extension}
```
* Where `YOUR_NEW_BUCKET_NAME` is the bucket defined in the `s3_bucket_name` variable.

* The `tileset` is a directory name with any unique URI-safe alphanumeric name to identify individual tilesets.

* The `version` is a directory with any unique URI-safe alphanumeric name to differentiate versions of the tile set. For example `2022-06-28`.

* The `tile.json` file should be a [TileJSON](https://github.com/mapbox/tilejson-spec) file describing the tileset and with the `tiles` attribute pointing to the newly created API Gateway instance.

* The `tilefile` is a directory name with any unique URI-safe alphanumeric name to identify individual tilefiles.

* The `file.extension` file should be a single-archive tilefile that supports range requests.

Example complete S3 tileset path:

```
s3://YOUR_NEW_BUCKET_NAME/oprvrs/2022-04-01/0/494/347.pbf
```

Example complete S3 tilefile path:

```
s3://YOUR_NEW_BUCKET_NAME/opmosm/2022-04-01/florence.tif
```

### Content Encoding

The module can support compressed tiles if the content-encoding metadata is appended to files in the S3 bucket during upload. Additionally the content-type header can also be set if required by client application. Note that on-the-fly compression by API Gateway is not currently supported.

For example when uploading a vector tileset with gzip compression: 

```shell
aws s3 cp --recursive my-tile-set/ s3://YOUR_NEW_BUCKET_NAME/TILESET/VERSION/ --content-encoding gzip --content-type application/x-protobuf
```

Subsequent API requests for these tiles will return `Content-encoding` and `Content-type` response headers. 

### API

The API exposes the following endpoints:

#### **Get TileJSON**
```http
GET /{API_INVOKE_URL}/v1/{tileset}/
X-Api-Key: {API_KEY}
```

#### **Get Tileset tile**
```http
GET /{API_INVOKE_URL}/v1/{tileset}/{version}/{z}/{x}/{y}
X-Api-Key: {API_KEY}
```

#### **Get part of a Tilefile**
```http
GET /{API_INVOKE_URL}/v1/{tilefile}/{version}/{file.extension}
X-Api-Key: {API_KEY}
Range: 0-255
```

#### Maximum Payload Size

Note that the maximum payload size for API Gateway is [10 MB](https://docs.aws.amazon.com/apigateway/latest/developerguide/limits.html#api-gateway-execution-service-limits-table). Requesting tiles larger than this will return a 500 error.

#### CORS
All endpoints support `OPTIONS` requests for CORS. See [examples/lambda-authorizer](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/lambda-authorizer) for an example of custom header configuration.

#### API Key
The module automatically requires an API Gateway API key to be present in all requests using the `X-API-KEY` header. The example in [examples/api-key](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/api-key) demonstrates creation of an API key and usage plan. Alternatively the API key requirement can be completely disabled by setting the `api_require_api_key` variable to `false`. Note that this may expose an API to public access.

#### Errors

The following error types are supported:

* 404 - not found (missing file/tile)
* 403 - forbidden (failed authorization)
* 500 - internal server error (all other errors)

#### Version Path

The module includes a `v1` in the path to future proof against breaking changes to the API.

## Client Demos

|Demo|Source|API Endpoint|Client|Data Format|Data Source|
|----|------|------------|------|-----------|-----------|
|[Vector tileset](https://addresscloud.github.io/terraform-aws-tile-service/)|[github](https://github.com/addresscloud/terraform-aws-tile-service/blob/demo/index.html)|/tileset|MapLibre|Compressed protocol-buffers (.pbf)|OpenMapTiles|
|[Raster tileset](https://addresscloud.github.io/terraform-aws-tile-service/raster/)|[github](https://github.com/addresscloud/terraform-aws-tile-service/blob/demo/raster/index.html)|/tileset|MapLibre|Portable network graphic (.png)|Sentinel/ESA|
|[PMTile](https://addresscloud.github.io/terraform-aws-tile-service/pmtile/)|[github](https://github.com/addresscloud/terraform-aws-tile-service/blob/demo/pmtile/index.html)|/tilefile|MapLibre + PMTile plugin|PMTile|OpenMapTiles|
|[COG](https://addresscloud.github.io/terraform-aws-tile-service/cog/)|[github](https://github.com/addresscloud/terraform-aws-tile-service/blob/demo/cog/index.html)|/tilefile|Geotiff.js + Plotty|Cloud Optimised GeoTiff|Sentinel/ESA|

## Configuration Examples

- [api key configuration](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/api-key)
- [caching](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/caching)
- [custom domain name](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/custom-domain)
- [deployment trigger](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/deployment-trigger)
- [lambda authorization](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/lambda-authorizer)
- [tilejson response template](https://github.com/addresscloud/terraform-aws-tile-service/tree/main/examples/tilejson-response-template)

## About

The module uses Amazon API Gateway and S3 to provision a vector tile API suitable for modern mapping libraries such as [MapLibre](https://maplibre.org/) and [Mapbox](https://www.mapbox.com/).

API Gateway is particularly useful when authorization is required to protect non-public data sources. S3 provides a secure and scaleable storage backend and when used with API Gateway removes the need for any server-side logic or functions. The module's serverless architecture means that the service is highly-scaleable.

## Presentations
- [FOSS4G 2022 lightning talk slides](https://addresscloud.github.io/terraform-aws-tile-service/decks/foss4g-20220825.pdf)
- [FOSS4G UK 2022 presentation recording](https://www.youtube.com/watch?v=c5MR2CmM6-M)

### Alternatives

These alternatives influenced the design of this module should be considered if API Gateway features are not needed.

- [CloudFront + S3](https://github.com/addresscloud/serverless-tiles) the leanest way to self-host tiles
- [TiTiler](https://github.com/developmentseed/titiler) supports multiple data types including rasters using Lambda functions
- [MapTiler Cloud](https://www.maptiler.com/cloud/) excellent commercial solution when self-hosting is not required

### Maintainers

This module is maintained by [Addresscloud](https://github.com/addresscloud/).

### Contributing

PRs accepted.

### License

[MIT](https://github.com/addresscloud/terraform-aws-tile-service/blob/main/LICENSE) © 2022 Addresscloud Limited
