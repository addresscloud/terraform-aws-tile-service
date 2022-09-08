resource "aws_api_gateway_method" "json_get" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.tileset.id
  http_method      = "GET"
  authorization    = var.api_custom_authorizer_arn != "" ? "CUSTOM" : "NONE"
  authorizer_id    = var.api_custom_authorizer_arn != "" ? var.api_custom_authorizer_arn : null
  api_key_required = var.api_require_api_key
  request_parameters = {
    "method.request.path.tileset" = true
  }
}

resource "aws_api_gateway_method" "json_options" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.tileset.id
  http_method      = "OPTIONS"
  authorization    = "NONE"
  api_key_required = false
  request_parameters = {
    "method.request.path.tileset" = true
  }
}

resource "aws_api_gateway_method" "tile_get" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.y.id
  http_method      = "GET"
  authorization    = var.api_custom_authorizer_arn != "" ? "CUSTOM" : "NONE"
  authorizer_id    = var.api_custom_authorizer_arn != "" ? var.api_custom_authorizer_arn : null
  api_key_required = var.api_require_api_key
  request_parameters = {
    "method.request.path.tileset" = true
    "method.request.path.version" = true
    "method.request.path.z"       = true
    "method.request.path.x"       = true
    "method.request.path.y"       = true
  }
}

resource "aws_api_gateway_method" "tile_options" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.y.id
  http_method      = "OPTIONS"
  authorization    = "NONE"
  api_key_required = false
  request_parameters = {
    "method.request.path.tileset" = true
    "method.request.path.version" = true
    "method.request.path.z"       = true
    "method.request.path.x"       = true
    "method.request.path.y"       = true
  }
}

resource "aws_api_gateway_method" "filekey_get" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.filekey.id
  http_method      = "GET"
  authorization    = var.api_custom_authorizer_arn != "" ? "CUSTOM" : "NONE"
  authorizer_id    = var.api_custom_authorizer_arn != "" ? var.api_custom_authorizer_arn : null
  api_key_required = var.api_require_api_key
  request_parameters = {
    "method.request.header.range"  = true
    "method.request.path.tilefile" = true
    "method.request.path.version"  = true
    "method.request.path.filekey"  = true
  }
}

resource "aws_api_gateway_method" "filekey_options" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.filekey.id
  http_method      = "OPTIONS"
  authorization    = "NONE"
  api_key_required = false
  request_parameters = {
    "method.request.header.range"  = true
    "method.request.path.tilefile" = true
    "method.request.path.version"  = true
    "method.request.path.filekey"  = true
  }
}

resource "aws_api_gateway_method" "filekey_head" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.filekey.id
  http_method      = "HEAD"
  authorization    = var.api_custom_authorizer_arn != "" ? "CUSTOM" : "NONE"
  authorizer_id    = var.api_custom_authorizer_arn != "" ? var.api_custom_authorizer_arn : null
  api_key_required = var.api_require_api_key
  request_parameters = {
    "method.request.header.range"  = true
    "method.request.path.tilefile" = true
    "method.request.path.version"  = true
    "method.request.path.filekey"  = true
  }
}