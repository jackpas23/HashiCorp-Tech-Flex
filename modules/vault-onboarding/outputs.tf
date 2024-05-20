output "namespace" {
  value = vault_namespace.namespace.path
}

output "username" {
  value = var.username
}

output "password" {
  value = var.password
  sensitive = true
}

output "admin_password" {
  value = var.admin_password
  sensitive = true
}
output "onboarding_complete" {
  value = "onboarding_complete"
}
