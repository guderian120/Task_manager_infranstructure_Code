output "lambda_functions" {
  description = "Map of Lambda function names to their ARNs"
  value = { for name in var.lambda_functions : name => aws_lambda_function.functions[name].arn }
}