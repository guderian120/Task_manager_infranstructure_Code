variable "region" {
  description = "The AWS region to deploy resources in (Region B)"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "The name of the project, used as a prefix for resource names"
  type        = string
  default     = "Task_Manager_App"
}

variable "s3_bucket_name" {
  description = "The globally unique name for the S3 bucket hosting the Vue.js app"
  type        = string
    default     = "task-manager-app-vue-bucket"
}

variable "cognito_user_pool_name" {
  description = "The name of the Cognito User Pool"
  type        = string
  default     = "task-manager-user-pool"
}

variable "lambda_functions" {
  description = "List of names for the Lambda functions"
  type        = list(string)
  default     = [
    "create_task",
    "delete_task",
  ]
}

variable "environment" {
  description = "The environment for the deployment (e.g., prod, dev)"
  type        = string
  default     = "dev"
}