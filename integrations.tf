resource "aws_api_gateway_integration" "json_get" {
  rest_api_id             = aws_api_gateway_rest_api.tile.id
  resource_id             = aws_api_gateway_resource.tileset.id
  http_method             = aws_api_gateway_method.json_get.http_method
  type                    = "AWS"
  integration_http_method = "GET"
  credentials             = aws_iam_role.tile.arn
  uri                     = local.tile_json_uri
  request_parameters = {
    "integration.request.path.tileset" = "method.request.path.tileset"
  }
  depends_on = [
    aws_api_gateway_method.json_get
  ]
}

resource "aws_api_gateway_integration" "json_options" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.tileset.id
  http_method      = aws_api_gateway_method.json_options.http_method
  type             = "MOCK"
  depends_on       = [aws_api_gateway_method.json_options]
  content_handling = "CONVERT_TO_TEXT"
  request_templates = {
    "application/json" = jsonencode(
      {
        "statusCode" : 200
      }
    )
  }
}

resource "aws_api_gateway_integration" "tile_get" {
  rest_api_id             = aws_api_gateway_rest_api.tile.id
  resource_id             = aws_api_gateway_resource.y.id
  http_method             = aws_api_gateway_method.tile_get.http_method
  type                    = "AWS"
  integration_http_method = "GET"
  credentials             = aws_iam_role.tile.arn
  uri                     = "arn:aws:apigateway:${var.api_region}:s3:path/${var.s3_bucket_name}/{tileset}/{version}/{z}/{x}/{y}"
  request_parameters = {
    "integration.request.path.tileset" = "method.request.path.tileset"
    "integration.request.path.version" = "method.request.path.version"
    "integration.request.path.z"       = "method.request.path.z"
    "integration.request.path.x"       = "method.request.path.x"
    "integration.request.path.y"       = "method.request.path.y"
  }
  cache_key_parameters = [
    "method.request.path.tileset",
    "method.request.path.version",
    "method.request.path.x",
    "method.request.path.y",
    "method.request.path.z",
  ]
  depends_on = [
    aws_api_gateway_method.tile_get
  ]
}

resource "aws_api_gateway_integration" "tile_options" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.y.id
  http_method      = aws_api_gateway_method.tile_options.http_method
  type             = "MOCK"
  depends_on       = [aws_api_gateway_method.tile_options]
  content_handling = "CONVERT_TO_TEXT"
  request_templates = {
    "application/json" = jsonencode(
      {
        "statusCode" : 200
      }
    )
  }
}

resource "aws_api_gateway_integration" "filekey_get" {
  rest_api_id             = aws_api_gateway_rest_api.tile.id
  resource_id             = aws_api_gateway_resource.filekey.id
  http_method             = aws_api_gateway_method.filekey_get.http_method
  type                    = "AWS"
  integration_http_method = "GET"
  credentials             = aws_iam_role.tile.arn
  uri                     = "arn:aws:apigateway:${var.api_region}:s3:path/${var.s3_bucket_name}/{tilefile}/{version}/{filekey}"
  request_parameters = {
    "integration.request.header.range"  = "method.request.header.range"
    "integration.request.path.tilefile" = "method.request.path.tilefile"
    "integration.request.path.version"  = "method.request.path.version"
    "integration.request.path.filekey"  = "method.request.path.filekey"
  }
  depends_on = [
    aws_api_gateway_method.filekey_get
  ]
}

resource "aws_api_gateway_integration" "filekey_options" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.filekey.id
  http_method      = aws_api_gateway_method.filekey_options.http_method
  type             = "MOCK"
  depends_on       = [aws_api_gateway_method.filekey_options]
  content_handling = "CONVERT_TO_TEXT"
  request_templates = {
    "application/json" = jsonencode(
      {
        "statusCode" : 200
      }
    )
  }
}

resource "aws_api_gateway_integration" "filekey_head" {
  rest_api_id             = aws_api_gateway_rest_api.tile.id
  resource_id             = aws_api_gateway_resource.filekey.id
  http_method             = aws_api_gateway_method.filekey_head.http_method
  type                    = "AWS"
  integration_http_method = "HEAD"
  credentials             = aws_iam_role.tile.arn
  uri                     = "arn:aws:apigateway:${var.api_region}:s3:path/${var.s3_bucket_name}/{tilefile}/{version}/{filekey}"
  request_parameters = {
    "integration.request.header.range"  = "method.request.header.range"
    "integration.request.path.tilefile" = "method.request.path.tilefile"
    "integration.request.path.version"  = "method.request.path.version"
    "integration.request.path.filekey"  = "method.request.path.filekey"
  }
  depends_on = [
    aws_api_gateway_method.filekey_head
  ]
}