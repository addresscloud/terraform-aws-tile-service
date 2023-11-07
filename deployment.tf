locals {
  trigger = var.api_deployment_trigger != "" ? var.api_deployment_trigger : timestamp()
}

resource "aws_api_gateway_deployment" "tile" {
  for_each = var.api_stages

  rest_api_id = aws_api_gateway_rest_api.tile.id
  description = local.trigger
  lifecycle {
    create_before_destroy = true
  }
  triggers = {
    "redeployment" = local.trigger
  }
  depends_on = [
    aws_api_gateway_rest_api.tile,
    aws_api_gateway_method.json_get,
    aws_api_gateway_method.json_options,
    aws_api_gateway_method.tile_get,
    aws_api_gateway_method.tile_options
  ]
}

resource "aws_api_gateway_stage" "tile" {
  for_each              = var.api_stages
  stage_name            = each.value.name
  rest_api_id           = aws_api_gateway_rest_api.tile.id
  deployment_id         = aws_api_gateway_deployment.tile[each.key].id
  cache_cluster_enabled = each.value.cach_size != 0 ? true : false
  cache_cluster_size    = each.value.cach_size != 0 ? each.value.cache_size : null
  xray_tracing_enabled  = each.value.xray_tracing_enabled
}