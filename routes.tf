resource "aws_api_gateway_resource" "v1" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_rest_api.tile.root_resource_id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "tileset_path" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "tileset"
}

resource "aws_api_gateway_resource" "tileset" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.tileset_path.id
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

resource "aws_api_gateway_resource" "tilefile_path" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "tilefile"
}

resource "aws_api_gateway_resource" "tilefile" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.tilefile_path.id
  path_part   = "{tilefile}"
}

resource "aws_api_gateway_resource" "tilefile_version" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.tilefile.id
  path_part   = "{version}"
}

resource "aws_api_gateway_resource" "filekey" {
  rest_api_id = aws_api_gateway_rest_api.tile.id
  parent_id   = aws_api_gateway_resource.tilefile_version.id
  path_part   = "{filekey}"
}
