resource "task_manager_amplify_app" "vue_app" {
  name        = "${var.project_name}-amplify"
  description = "Amplify app for ${var.project_name} Vue.js frontend"

  # Environment variables for Cognito integration
  environment_variables = {
    AWS_COGNITO_USER_POOL_ID     = var.user_pool_id
    AWS_COGNITO_USER_POOL_CLIENT_ID = var.user_pool_client_id
    AWS_REGION                   = "eu-west-1"
  }

  # Custom rule for Vue.js SPA routing
  custom_rule {
    source = "/<*>"
    target = "/index.html"
    status = "200"
  }

  # Enable auto branch creation (optional, can be disabled if manual)
  enable_auto_branch_creation = false

  tags = {
    Name        = "${var.project_name}-amplify"
    Environment = var.environment
  }
}

resource "task_manager_amplify_branch" "main" {
  app_id      = task_manager_amplify_app.vue_app.id
  branch_name = "main"

  # Enable auto-build (set to false for manual deployment)
  enable_auto_build = false

  tags = {
    Name        = "${var.project_name}-main-branch"
    Environment = var.environment
  }
}