variable "s3_bucket_name" {
  description = "Name of S3 bucket where tiles will be stored."
  type        = string
}

variable "s3_bucket_policy" {
  description = "A customised policy for the S3 bucket to support advanced use cases."
  type        = string
}