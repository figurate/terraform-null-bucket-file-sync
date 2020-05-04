variable "bucket_name" {
  description = "The URL of the S3-compatible bucket to sync with"
}

variable "env_config" {
  description = "Additional environment variables to apply to the file sync command"
  type        = map(string)
  default     = {}
}

variable "endpoint_url" {
  description = "The URL of the S3-compatible endpoint where the bucket is hosted"
  default     = ""
}

variable "bucket_fqdn" {
  description = "The domain name of the S3-compatible bucket for s3cmd operations"
  default     = ""
}

variable "content_path" {
  description = "Root path of local website content"
  default     = "."
}

variable "includes" {
  description = "A list of include filters to apply"
  type        = list(string)
  default     = []
}

variable "excludes" {
  description = "A list of exclude filters to apply"
  type        = list(string)
  default     = ["*"]
}

variable "acl" {
  description = "Set permissions of uploaded files"
  default     = ""
}

variable "delete" {
  description = "Remove files from the destination that don't exist in the source"
  default     = "false"
}

locals {
  excludes_string = "--exclude \"${join("\" --exclude \"", var.excludes)}\""
  includes_string = "--include \"${join("\" --include \"", var.includes)}\""
}
