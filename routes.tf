resource "aws_api_gateway_resource" "v1" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_rest_api.tile.root_resource_id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "tileset" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "{tileset}"
}

resource "aws_api_gateway_resource" "version" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.tileset.id
  path_part   = "{version}"
}

resource "aws_api_gateway_resource" "z" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.version.id
  path_part   = "{z}"
}

resource "aws_api_gateway_resource" "x" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.z.id
  path_part   = "{x}"
}

resource "aws_api_gateway_resource" "y" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.x.id
  path_part   = "{y}"
}