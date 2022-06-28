resource "aws_api_gateway_gateway_response" "ACCESS_DENIED" {
  rest_api_id   = aws_api_gateway_rest_api.tile.id
  response_type = "ACCESS_DENIED"
  status_code   = "403"
  response_templates = {
    "application/json" = "{\"message\":\"Access denied\"}"
  }
  response_parameters = {
    "gatewayresponse.header.access-control-allow-origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_gateway_response" "BAD_REQUEST_BODY" {
  rest_api_id   = aws_api_gateway_rest_api.tile.id
  response_type = "BAD_REQUEST_BODY"
  status_code   = "400"
  response_templates = {
    "application/json" = "{\"message\": \"$context.error.validationErrorString\"}"
  }

  response_parameters = {
    "gatewayresponse.header.access-control-allow-origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_gateway_response" "BAD_REQUEST_PARAMETERS" {
  rest_api_id   = aws_api_gateway_rest_api.tile.id
  response_type = "BAD_REQUEST_PARAMETERS"
  status_code   = "400"
  response_templates = {
    "application/json" = "{\"message\": \"Missing request parameter: $context.error.validationErrorString\"}"
  }

  response_parameters = {
    "gatewayresponse.header.access-control-allow-origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_gateway_response" "MISSING_AUTHENTICATION_TOKEN" {
  rest_api_id   = aws_api_gateway_rest_api.tile.id
  response_type = "MISSING_AUTHENTICATION_TOKEN"
  status_code   = "404"
  response_templates = {
    "application/json" = "{\"message\": \"Not found\"}",
  }

  response_parameters = {
    "gatewayresponse.header.access-control-allow-origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_gateway_response" "DEFAULT_4XX" {
  rest_api_id   = aws_api_gateway_rest_api.tile.id
  response_type = "DEFAULT_4XX"

  response_templates = {
    "application/json" = "{\"message\":\"$context.error.messageString\"}"
  }

  response_parameters = {
    "gatewayresponse.header.access-control-allow-origin" = var.api_access_control_allow_origin
  }
}

resource "aws_api_gateway_gateway_response" "DEFAULT_5XX" {
  rest_api_id   = aws_api_gateway_rest_api.tile.id
  response_type = "DEFAULT_5XX"

  response_templates = {
    "application/json" = "{\"message\":\"$context.error.messageString\"}"
  }

  response_parameters = {
    "gatewayresponse.header.access-control-allow-origin" = var.api_access_control_allow_origin
  }
}