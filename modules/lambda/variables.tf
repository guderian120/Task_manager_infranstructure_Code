variable "lambda_functions" {
  description = "List of names for the Lambda functions"
  type        = list(string)
}

variable "project_name" {
  description = "The name of the project, used as a prefix for resource names"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (e.g., prod, dev)"
  type        = string
}