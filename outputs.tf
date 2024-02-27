output "api_id" {
  description = "API identifier."
  value       = aws_api_gateway_rest_api.tile.id
}

output "api_stage_invoke_url" {
  description = "API invoke URL for stages."
  value = {
    for stage in aws_api_gateway_stage.tile : stage.stage_name => stage.invoke_url
  }
}