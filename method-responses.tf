resource "aws_api_gateway_method_response" "json_get" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.tileset.id
  http_method = aws_api_gateway_method.json_get.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Credentials" = true
    "method.response.header.Access-Control-Allow-Origin"      = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_method.json_get
  ]
}

resource "aws_api_gateway_method_response" "json_options" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.tileset.id
  http_method = aws_api_gateway_method.json_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Credentials" = true
    "method.response.header.Access-Control-Allow-Headers"     = true
    "method.response.header.Access-Control-Allow-Methods"     = true
    "method.response.header.Access-Control-Allow-Origin"      = true
  }

  response_models = {
    "application/json" = "Empty"
  }

  depends_on = [aws_api_gateway_method.json_options]
}

resource "aws_api_gateway_method_response" "tile_get" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.y.id
  http_method = aws_api_gateway_method.tile_get.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Content-Type"                     = true
    "method.response.header.Access-Control-Allow-Credentials" = true
    "method.response.header.Access-Control-Allow-Origin"      = true
    "method.response.header.Content-Encoding"                 = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_method.tile_get
  ]
}

resource "aws_api_gateway_method_response" "tile_options" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.y.id
  http_method = aws_api_gateway_method.tile_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Credentials" = true
    "method.response.header.Access-Control-Allow-Headers"     = true
    "method.response.header.Access-Control-Allow-Methods"     = true
    "method.response.header.Access-Control-Allow-Origin"      = true
  }

  response_models = {
    "application/json" = "Empty"
  }

  depends_on = [aws_api_gateway_method.tile_options]
}