output "api_endpoint" {
  description = "The endpoint URL of the API Gateway"
  value       = "https://${aws_api_gateway_rest_api.api.id}.execute-api.eu-west-1.amazonaws.com/${var.environment}"
}