resource "aws_api_gateway_integration_response" "json_get" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.tileset.id
  http_method = aws_api_gateway_method.json_get.http_method
  status_code = aws_api_gateway_method_response.json_get.status_code
  depends_on  = [aws_api_gateway_method.json_get, aws_api_gateway_integration.json_get]
  response_templates = {
    "application/json" = var.api_tilejson_response_template
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_integration_response" "json_get_404" {
  rest_api_id       = aws_api_gateway_rest_api.tile.id
  resource_id       = aws_api_gateway_resource.tileset.id
  http_method       = aws_api_gateway_method.json_get.http_method
  status_code       = 404
  selection_pattern = "404"
  depends_on        = [aws_api_gateway_method.json_get, aws_api_gateway_integration.json_get]
  response_templates = {
    "application/json" = "{\"message\":\"Not found\"}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_integration_response" "json_get_403" {
  rest_api_id       = aws_api_gateway_rest_api.tile.id
  resource_id       = aws_api_gateway_resource.tileset.id
  http_method       = aws_api_gateway_method.json_get.http_method
  status_code       = aws_api_gateway_method_response.json_get_403.status_code
  selection_pattern = "403"
  depends_on        = [aws_api_gateway_method.json_get, aws_api_gateway_integration.json_get, aws_api_gateway_method_response.json_get_403]
  response_templates = {
    "application/json" = "{\"message\":\"Forbidden\"}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_integration_response" "json_get_500" {
  rest_api_id       = aws_api_gateway_rest_api.tile.id
  resource_id       = aws_api_gateway_resource.tileset.id
  http_method       = aws_api_gateway_method.json_get.http_method
  status_code       = aws_api_gateway_method_response.json_get_500.status_code
  selection_pattern = "5\\d{2}"
  depends_on        = [aws_api_gateway_method.json_get, aws_api_gateway_integration.json_get, aws_api_gateway_method_response.json_get_500]
  response_templates = {
    "application/json" = "{\"message\":\"Unexpected error\"}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}


resource "aws_api_gateway_integration_response" "json_options" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.tileset.id
  http_method      = aws_api_gateway_method.json_options.http_method
  status_code      = aws_api_gateway_method_response.json_options.status_code
  depends_on       = [aws_api_gateway_method.json_options, aws_api_gateway_integration.json_options]
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = var.api_access_control_allow_headers
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = var.api_access_control_allow_origin
  }

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_integration_response" "tile_get" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.y.id
  http_method = aws_api_gateway_method.tile_get.http_method
  status_code = aws_api_gateway_method_response.tile_get.status_code
  depends_on  = [aws_api_gateway_method.tile_get, aws_api_gateway_integration.tile_get]
  response_templates = {
    "application/json" = ""
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
    "method.response.header.Content-Type"                = "integration.response.header.Content-Type"
    "method.response.header.Content-Encoding"            = "integration.response.header.Content-Encoding"
  }
}

resource "aws_api_gateway_integration_response" "tile_get_404" {
  rest_api_id       = aws_api_gateway_rest_api.tile.id
  resource_id       = aws_api_gateway_resource.y.id
  http_method       = aws_api_gateway_method.tile_get.http_method
  status_code       = 404
  selection_pattern = "404"
  depends_on        = [aws_api_gateway_method.tile_get, aws_api_gateway_integration.tile_get]
  response_templates = {
    "application/json" = "{\"message\":\"Not found\"}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_integration_response" "tile_get_403" {
  rest_api_id       = aws_api_gateway_rest_api.tile.id
  resource_id       = aws_api_gateway_resource.y.id
  http_method       = aws_api_gateway_method.tile_get.http_method
  status_code       = aws_api_gateway_method_response.tile_get_403.status_code
  selection_pattern = "403"
  depends_on        = [aws_api_gateway_method.tile_get, aws_api_gateway_integration.tile_get, aws_api_gateway_method_response.tile_get_403]
  response_templates = {
    "application/json" = "{\"message\":\"Forbidden\"}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_integration_response" "tile_get_500" {
  rest_api_id       = aws_api_gateway_rest_api.tile.id
  resource_id       = aws_api_gateway_resource.y.id
  http_method       = aws_api_gateway_method.tile_get.http_method
  status_code       = aws_api_gateway_method_response.tile_get_500.status_code
  selection_pattern = "5\\d{2}"
  depends_on        = [aws_api_gateway_method.tile_get, aws_api_gateway_integration.tile_get, aws_api_gateway_method_response.tile_get_500]
  response_templates = {
    "application/json" = "{\"message\":\"Unexpected error\"}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_integration_response" "tile_options" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.y.id
  http_method      = aws_api_gateway_method.tile_options.http_method
  status_code      = aws_api_gateway_method_response.tile_options.status_code
  depends_on       = [aws_api_gateway_method.tile_options, aws_api_gateway_integration.tile_options]
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = var.api_access_control_allow_headers
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = var.api_access_control_allow_origin
  }

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_integration_response" "filekey_get" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.filekey.id
  http_method = aws_api_gateway_method.filekey_get.http_method
  status_code = aws_api_gateway_method_response.filekey_get.status_code
  depends_on  = [aws_api_gateway_method.filekey_get, aws_api_gateway_integration.filekey_get]
  response_templates = {
    "application/json" = ""
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
    "method.response.header.Content-Type"                = "integration.response.header.Content-Type"
    "method.response.header.Content-Encoding"            = "integration.response.header.Content-Encoding"
    "method.response.header.Content-Length"              = "integration.response.header.Content-Length"
  }
}


resource "aws_api_gateway_integration_response" "filekey_get_206" {
  rest_api_id       = aws_api_gateway_rest_api.tile.id
  resource_id       = aws_api_gateway_resource.filekey.id
  http_method       = aws_api_gateway_method.filekey_get.http_method
  status_code       = 206
  selection_pattern = "206"
  depends_on        = [aws_api_gateway_method.filekey_get, aws_api_gateway_integration.filekey_get, aws_api_gateway_method_response.filekey_get_206]
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_integration_response" "filekey_get_404" {
  rest_api_id       = aws_api_gateway_rest_api.tile.id
  resource_id       = aws_api_gateway_resource.filekey.id
  http_method       = aws_api_gateway_method.filekey_get.http_method
  status_code       = 404
  selection_pattern = "404"
  depends_on        = [aws_api_gateway_method.filekey_get, aws_api_gateway_integration.filekey_get, aws_api_gateway_method_response.filekey_get_404]
  response_templates = {
    "application/json" = "{\"message\":\"Not found\"}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_integration_response" "filekey_get_403" {
  rest_api_id       = aws_api_gateway_rest_api.tile.id
  resource_id       = aws_api_gateway_resource.filekey.id
  http_method       = aws_api_gateway_method.filekey_get.http_method
  status_code       = aws_api_gateway_method_response.filekey_get_403.status_code
  selection_pattern = "403"
  depends_on        = [aws_api_gateway_method.filekey_get, aws_api_gateway_integration.filekey_get, aws_api_gateway_method_response.filekey_get_403]
  response_templates = {
    "application/json" = "{\"message\":\"Forbidden\"}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_integration_response" "filekey_get_500" {
  rest_api_id       = aws_api_gateway_rest_api.tile.id
  resource_id       = aws_api_gateway_resource.filekey.id
  http_method       = aws_api_gateway_method.filekey_get.http_method
  status_code       = aws_api_gateway_method_response.filekey_get_500.status_code
  selection_pattern = "5\\d{2}"
  depends_on        = [aws_api_gateway_method.filekey_get, aws_api_gateway_integration.filekey_get, aws_api_gateway_method_response.filekey_get_500]
  response_templates = {
    "application/json" = "{\"message\":\"Unexpected error\"}"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_integration_response" "filekey_options" {
  rest_api_id      = aws_api_gateway_rest_api.tile.id
  resource_id      = aws_api_gateway_resource.filekey.id
  http_method      = aws_api_gateway_method.filekey_options.http_method
  status_code      = aws_api_gateway_method_response.filekey_options.status_code
  depends_on       = [aws_api_gateway_method.filekey_options, aws_api_gateway_integration.filekey_options]
  content_handling = "CONVERT_TO_TEXT"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = var.api_access_control_allow_headers
    "method.response.header.Access-Control-Allow-Methods" = "'GET,HEAD,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = var.api_access_control_allow_origin
  }

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_integration_response" "filekey_head" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  resource_id = aws_api_gateway_resource.filekey.id
  http_method = aws_api_gateway_method.filekey_head.http_method
  status_code = aws_api_gateway_method_response.filekey_head.status_code
  depends_on  = [aws_api_gateway_method.filekey_head, aws_api_gateway_integration.filekey_head]
  response_templates = {
    "application/json" = ""
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.api_access_control_allow_origin
    "method.response.header.accept-ranges"               = "integration.response.header.accept-ranges"
    "method.response.header.Content-Type"                = "integration.response.header.Content-Type"
    "method.response.header.Content-Encoding"            = "integration.response.header.Content-Encoding"
    "method.response.header.Content-Length"              = "integration.response.header.Content-Length"
  }
}
