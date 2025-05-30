variable "project_name" {
  description = "The name of the project, used as a prefix for resource names"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (e.g., prod, dev)"
  type        = string
}

variable "user_pool_id" {
  description = "The ID of the Cognito User Pool for authentication"
  type        = string
}

variable "user_pool_client_id" {
  description = "The ID of the Cognito User Pool Client"
  type        = string
}