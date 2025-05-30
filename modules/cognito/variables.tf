variable "user_pool_name" {
  description = "The name of the Cognito User Pool"
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


variable "cloudfront_domain" {
  description = "The CloudFront distribution domain name for callback and logout URLs"
  type        = string
}