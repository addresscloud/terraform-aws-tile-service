output "api_id" {
  description = "API identifier."
  value       = aws_api_gateway_rest_api.tile.id
}

output "api_stage_name" {
  description = "API stage name."
  value       = aws_api_gateway_stage.tile.stage_name
}

output "api_invoke_url" {
    description = "API invoke URL."
    value = aws_api_gateway_deployment.tile.invoke_url
}