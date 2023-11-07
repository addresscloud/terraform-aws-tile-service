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

# variable "api_throttling_burst_limit" {
#   description = "API burst limit tps. Maximum burst limit of transactions per second allowed for this API. Defaults to `100`. Use this setting to prevent the tile service from consuming too too many burst many transactions from the AWS account quota."
#   default     = 100
#   type        = number
# }

# variable "api_throttling_rate_limit" {
#   description = "API rate limit tps. Maximum limit of transactions per second allowed for this API. Defaults to `500`. Use this setting to prevent the tile service from consuming too many transactions from the AWS account quota."
#   default     = 500
#   type        = number
# }

variable "s3_bucket_policy" {
  description = "A customised policy for the S3 bucket to support advanced use cases"
  default     = ""
  type        = string
}

variable "api_stages" {
  type = map(object({
    name = string
    cache_size = optional(number, 0)
    cache_ttl = optional(number, 0)
    throttling_burst_limit = optional(number, 100)
    throttling_rate_limit = optional(number, 500)
    xray_tracing_enabled = optional(bool, false)
  }))
}