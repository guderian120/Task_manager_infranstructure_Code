resource "aws_s3_bucket" "vue_app_bucket" {
  bucket = var.bucket_name
  force_destroy = true
  tags = {
    Name        = "${var.project_name}-bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_website_configuration" "vue_app_website" {
  bucket = aws_s3_bucket.vue_app_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "vue_app_access" {
  bucket = aws_s3_bucket.vue_app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}