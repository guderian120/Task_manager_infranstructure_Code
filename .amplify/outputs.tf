output "app_id" {
  description = "The ID of the Amplify app"
  value       = task_manager_amplify_app.vue_app.id
}

output "default_domain" {
  description = "The default domain of the Amplify app"
  value       = task_manager_amplify_app.vue_app.default_domain
}