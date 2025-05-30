output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.vue_app_bucket.bucket
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.vue_app_bucket.arn
}

output "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket for CloudFront"
  value       = aws_s3_bucket.vue_app_bucket.bucket_regional_domain_name
}

output "website_endpoint" {
  description = "The website endpoint of the S3 bucket"
  value       = aws_s3_bucket_website_configuration.vue_app_website.website_endpoint
}