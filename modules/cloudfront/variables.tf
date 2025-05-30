variable "bucket_name" {
  description = "The name of the S3 bucket to serve via CloudFront"
  type        = string
}

variable "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket for CloudFront origin"
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