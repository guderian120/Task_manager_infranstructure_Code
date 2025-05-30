variable "bucket_name" {
  description = "The globally unique name for the S3 bucket hosting the Vue.js app"
  type        = string
}

variable "project_name" {
  description = "The name of the project, used as a prefix for resource names"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (e.g., prod, dev)"
  type        = string
}

