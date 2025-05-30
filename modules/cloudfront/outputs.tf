output "distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.vue_app_distribution.id
}

output "domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.vue_app_distribution.domain_name
}

output "distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.vue_app_distribution.arn
}