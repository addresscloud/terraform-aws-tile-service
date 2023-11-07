resource "aws_api_gateway_method_settings" "all" {
  depends_on  = [aws_api_gateway_deployment.tile, aws_api_gateway_stage.tile]
  rest_api_id = aws_api_gateway_rest_api.tile.id
  stage_name  = var.api_stage_name
  method_path = "*/*"
  settings {
    metrics_enabled        = true
    logging_level          = "ERROR"
    caching_enabled        = false
    throttling_burst_limit = var.api_throttling_burst_limit
    throttling_rate_limit  = var.api_throttling_rate_limit
  }
}

resource "aws_api_gateway_method_settings" "tile" {
  depends_on  = [aws_api_gateway_deployment.tile, aws_api_gateway_stage.tile]
  rest_api_id = aws_api_gateway_rest_api.tile.id
  stage_name  = var.api_stage_name
  method_path = "v1/{tileset}/{version}/{z}/{x}/{y}/GET"
  settings {
    metrics_enabled      = true
    logging_level        = "ERROR"
    caching_enabled      = var.api_cache_ttl != 0 ? true : false
    cache_ttl_in_seconds = var.api_cache_ttl
  }
}

resource "aws_api_gateway_method_settings" "file" {
  depends_on  = [aws_api_gateway_deployment.tile, aws_api_gateway_stage.tile]
  rest_api_id = aws_api_gateway_rest_api.tile.id
  stage_name  = var.api_stage_name
  method_path = "v1/{filekey}/GET"
  settings {
    metrics_enabled      = true
    logging_level        = "ERROR"
    caching_enabled      = var.api_cache_ttl != 0 ? true : false
    cache_ttl_in_seconds = var.api_cache_ttl
  }
}