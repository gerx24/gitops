variable "environment" {
  default     = null
  description = "Environment"
  type        = string
}

variable "bucket_name" {
  default     = null
  description = "Bucket name"
  type        = string
}

variable "lifecycle_rules" {
  default     = {}
  description = "Lifecycle rules object"
  type        = any
}
