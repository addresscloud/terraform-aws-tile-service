# API Key Example

By default the module requires an API key to access all endpoints. Because API key management and usage plan configuration is complex the module does not create these automatically but instead leaves it up to the user to manage. This example extends the [Quick Start]('../quickstart') guide to create an API key and usage plan in Terraform which can be included with calls to access the API. The key and usage plan are created in the instance not at the module level. 

## Terraform 

The Terraform code in [main.tf](examples/api-key/main.tf) creates a usage plan "dev" and an API key "developer-api-key" and links them to the tile API. The output `dev_api_key` is the value that can be included in the `x-api-key` header.

Note that this example also demonstrates setting the stage name to a custom variable ("dev") instead of the default value ("default") which can be useful when working with different environments.

## X-Api-Key

Use the value of `dev_api_key` for API calls to the service, for example:

```http
GET /v1/{tileset}/
X-Api-Key: {API_KEY}
```

## Map Libre Example

You can include this in MapLibre by filtering requests made to the API URL (`api_invoke_url`) and including the `dev_api_key` value.

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

Further documentation: https://maplibre.org/maplibre-gl-js-docs/api/map/#map-parameters