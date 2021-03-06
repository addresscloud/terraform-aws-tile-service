# Quick Start Example

This folder contains an example of Terraform code that uses the apigateway-tile-service module to deploy an API Gateway instance and S3 bucket as a tile server. I'm using the Ordnance Survey [Open Rivers](https://www.ordnancesurvey.co.uk/business-government/products/open-map-rivers) (`oprvrs`) data as an example.

## Terraform

1. Copy the contents of [main.tf]() into your local Terraform workspace and edit with your `<BUCKET>` and `<REGION>` parameters.

1. Run `terraform apply` to create the infrastructure in your AWS account. Note the value of the `api_invoke_url` output value.

## Data

Edit the `tiles` attribute of your TileJSON to point to the new API using the `api_invoke_url` value. For example:

```json
    ...
	"tilejson": "3.0.0",
	"name": "oprvrs",
	"tiles": ["<API_INVOKE_URL>/default/v1/oprvrs/20220629/{z}/{x}/{y}"],
	"scheme": "zxy",
    ...
```

Upload your TileJSON and tile cache to the new bucket. 

```sh
aws s3 cp tile.json s3://<BUCKET>/oprvrs/tile.json
```

```sh
aws s3 cp --recursive cache s3://<BUCKET>/oprvrs/
```

## API Key

If you don't have one create a new Usage Plan and API Key and add access to the newly created API. An example of doing this in Terraform can be found in [examples/api-key](../examples/api-key).

## Test

You should now be able to make requests aginst the API Gateway instance using the `api_invoke_url` value which is output from the module.

#### **Get TileJSON**
```http
GET <API_INVOKE_URL>/default/v1/{tileset}/
X-Api-Key: {API_KEY}
```

#### **Get a tile**
```http
GET <API_INVOKE_URL/default/v1/{tileset}/{z}/{x}/{y}
X-Api-Key: {API_KEY}
```

## MapLibre Example

```js
var map = new maplibregl.Map({
    container: 'map',
    style: style,
    center: [-1.737832, 52.814301],
    zoom: 12,
    transformRequest: (url, resourceType) => {
        if (url.startsWith('<api_invoke_url>')) {
            return {
                url,
                headers: { 'x-api-key': '<dev_api_key>'}
            }
        }
    }
});
```