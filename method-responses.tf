resource "aws_api_gateway_method_response" "json_get" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.tileset.id
  http_method = aws_api_gateway_method.json_get.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
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
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
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
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Content-Encoding"            = true
    "method.response.header.Content-Type"                = true
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
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }

  depends_on = [aws_api_gateway_method.tile_options]
}

resource "aws_api_gateway_method_response" "json_get_404" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.tileset.id
  http_method = aws_api_gateway_method.json_get.http_method
  status_code = "404"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_method.json_get
  ]
}

resource "aws_api_gateway_method_response" "tile_get_404" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.y.id
  http_method = aws_api_gateway_method.tile_get.http_method
  status_code = "404"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Content-Encoding"            = true
    "method.response.header.Content-Type"                = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_method.tile_get
  ]
}

resource "aws_api_gateway_method_response" "filekey_get" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.filekey.id
  http_method = aws_api_gateway_method.filekey_get.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.accept-ranges"               = true
    "method.response.header.Content-Type"                = true
    "method.response.header.Content-Encoding"            = true
    "method.response.header.Content-Length"              = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_method.filekey_get
  ]
}

resource "aws_api_gateway_method_response" "filekey_get_206" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.filekey.id
  http_method = aws_api_gateway_method.filekey_get.http_method
  status_code = "206"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.accept-ranges"               = true
    "method.response.header.Content-Type"                = true
    "method.response.header.Content-Encoding"            = true
    "method.response.header.Content-Length"              = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_method.filekey_get
  ]
}

resource "aws_api_gateway_method_response" "filekey_options" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.filekey.id
  http_method = aws_api_gateway_method.filekey_options.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.accept-ranges"                = true
    "method.response.header.Content-Type"                 = true
    "method.response.header.Content-Encoding"             = true
    "method.response.header.Content-Length"               = true
  }
  response_models = {
    "application/json" = "Empty"
  }

  depends_on = [aws_api_gateway_method.filekey_options]
}

resource "aws_api_gateway_method_response" "filekey_get_404" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.filekey.id
  http_method = aws_api_gateway_method.filekey_get.http_method
  status_code = "404"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.accept-ranges"               = true
    "method.response.header.Content-Type"                = true
    "method.response.header.Content-Encoding"            = true
    "method.response.header.Content-Length"              = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_method.filekey_get
  ]
}

resource "aws_api_gateway_method_response" "filekey_head" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.filekey.id
  http_method = aws_api_gateway_method.filekey_head.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.accept-ranges"               = true
    "method.response.header.Content-Type"                = true
    "method.response.header.Content-Encoding"            = true
    "method.response.header.Content-Length"              = true
  }
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_method.filekey_head
  ]
}