locals {
  trigger = var.api_deployment_trigger != "" ? null : timestamp()
}

resource "aws_api_gateway_deployment" "tile" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  description = local.trigger
  lifecycle {
    create_before_destroy = true
  }
  triggers = {
    "redeployment" = local.trigger
  }
  depends_on = [aws_api_gateway_rest_api.tile]
}

resource "aws_api_gateway_stage" "tile" {
  stage_name            = var.api_stage_name
  rest_api_id           = aws_api_gateway_rest_api.tile.id
  deployment_id         = aws_api_gateway_deployment.tile.id
  cache_cluster_enabled = var.api_cache_size != 0 ? true : false
  cache_cluster_size    = var.api_cache_size != 0 ? var.api_cache_size : null
  xray_tracing_enabled  = false
  depends_on            = [aws_api_gateway_deployment.tile]
}
