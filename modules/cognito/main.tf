resource "aws_cognito_user_pool" "user_pool" {
  name = var.user_pool_name

  # Password policy
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  # Allow users to sign in with email
  alias_attributes = ["email"]

  # Auto-verify email
  auto_verified_attributes = ["email"]

  # MFA and other settings can be added here if needed
  mfa_configuration = "OFF"

  tags = {
    Name        = "${var.project_name}-user-pool"
    Environment = var.environment
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  name         = "${var.project_name}-client"

  # No client secret for frontend apps
  generate_secret = false

  # Allowed OAuth flows and scopes for Amplify
  allowed_oauth_flows  = ["code", "implicit"]
  allowed_oauth_scopes = ["email", "openid", "profile"]
  callback_urls        = ["https://${var.cloudfront_domain}/"]
  logout_urls          = ["https://${var.cloudfront_domain}/"]

  # Enable token refresh
  explicit_auth_flows = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_USER_PASSWORD_AUTH"]

  # Prevent overwriting user attributes
  prevent_user_existence_errors = "ENABLED"
}