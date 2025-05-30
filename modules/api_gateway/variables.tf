variable "lambda_functions" {
  description = "Map of Lambda function names to their ARNs"
  type        = map(string)
}

variable "user_pool_arn" {
  description = "The ARN of the Cognito User Pool for authorization"
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

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  
}
