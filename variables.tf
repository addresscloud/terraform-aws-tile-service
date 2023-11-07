variable "api_name" {
  description = "The name of the API gateway instance."
  type        = string
}

variable "api_region" {
  description = "The region to deploy the API in."
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of S3 bucket where tiles will be stored."
  type        = string
}

variable "api_access_control_allow_origin" {
  description = "Access-Control-Allow-Origin header value added to GET and OPTIONS responses. Defaults to \"'*'\" to allow all origins. Only a single value is permitted. Values must be enclosed in single quotes."
  default     = "'*'"
  type        = string
}

variable "api_access_control_allow_headers" {
  description = "List of Access-Control-Allow-Headers header values to be added to OPTIONS responses. Values must be comma separated and the list enclosed in single quotes."
  default     = "'Content-Type,Range,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,X-Amz-Meta-Fileinfo'"
  type        = string
}

variable "api_binary_media_types" {
  description = "Tuple of binary media types for the API."
  default     = ["application/x-protobuf", "application/x-www-form-urlencoded", "image/*"]
  type        = list(string)
}

variable "api_cache_size" {
  description = "API cache cluster size in gigabytes. Used to cache responses from the GET tile endpoint, requests to tile.json are not cached. Allowed values include `0.5`, `1.6`, `6.1`, `13.5`, `28.4`, `58.2`, `118` and `237`. Note that API caching is not covered by the AWS Free Tier and will incur an hourly charge."
  default     = 0
  type        = number
}

variable "api_cache_ttl" {
  description = "API cache ttl in seconds. Used to set cache duration for responses from the GET tile endpoint. Setting to 0 disables caching. Allowed values range from `0` to `3600`."
  default     = 0
  type        = number
}

variable "api_custom_authorizer_arn" {
  description = "ARN for custom authorizer Lambda function triggered for all endpoints."
  default     = ""
  type        = string
}

variable "api_deployment_trigger" {
  description = "A value used to trigger API deployments. If not set then the module will use an internal timestamp to force redeployment for each Terraform run. See the examples for more advanced configuration."
  default     = ""
  type        = string
}

variable "api_tilejson_response_template" {
  description = "A custom value for the S3 integration response template for the TileJson endpoint. Enables modification of TileJson between S3 and API response."
  default     = ""
  type        = string
}

variable "api_require_api_key" {
  description = "Toggle API Gateway API Key requirement for all endpoints. The API key is passed using the `x-api-key` header. Enable by default, see the examples for key and usage plan configuration."
  default     = true
  type        = bool
}

variable "api_stage_name" {
  description = "Name for API stage."
  default     = "default"
  type        = string
}

variable "api_throttling_burst_limit" {
  description = "API burst limit tps. Maximum burst limit of transactions per second allowed for this API. Defaults to `100`. Use this setting to prevent the tile service from consuming too too many burst many transactions from the AWS account quota."
  default     = 100
  type        = number
}

variable "api_throttling_rate_limit" {
  description = "API rate limit tps. Maximum limit of transactions per second allowed for this API. Defaults to `500`. Use this setting to prevent the tile service from consuming too many transactions from the AWS account quota."
  default     = 500
  type        = number
}

variable "api_execution_role_policy_arns" {
  description = "Names and ARNs of additional policies to be attached to the API execution role."
  default     = {}
  type        = map(any)
}

variable "s3_bucket_policy" {
  description = "A customised policy for the S3 bucket to support advanced use cases."
  default     = ""
  type        = string
}

variable "s3_skip_creation" {
  description = "Optional override to skip creation of the S3 bucket and policies. Useful for when the bucket is created outside of Terraform."
  default     = false
  type        = bool
}

variable "tile_json_integration_override" {
  description = "Optional override for the TileJson integration URI."
  default     = ""
  type        = string
}
