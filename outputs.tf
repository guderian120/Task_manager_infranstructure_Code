output "s3_bucket_name" {
  description = "The name of the S3 bucket hosting the Vue.js app"
  value       = module.s3.bucket_name
}

output "s3_website_endpoint" {
  description = "The website endpoint of the S3 bucket"
  value       = module.s3.website_endpoint
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.cloudfront.domain_name
}

output "cognito_user_pool_id" {
  description = "The ID of the Cognito User Pool"
  value       = module.cognito.user_pool_id
}

output "cognito_user_pool_client_id" {
  description = "The ID of the Cognito User Pool Client"
  value       = module.cognito.user_pool_client_id
}

# output "amplify_app_id" {
#   description = "The ID of the Amplify app"
#   value       = module.amplify.app_id
# }

# output "amplify_default_domain" {
#   description = "The default domain of the Amplify app"
#   value       = module.amplify.default_domain
# }

output "api_gateway_endpoint" {
  description = "The endpoint URL of the API Gateway"
  value       = module.api_gateway.api_endpoint
}