resource "vault_auth_backend" "userpass" {
  type        = "userpass"
  description = "Userpass auth method"
  path        = "userpass"
  namespace   = vault_namespace.namespace.path
  depends_on  = [vault_namespace.namespace]
}

resource "vault_generic_endpoint" "userpass_user" {
  path = "auth/userpass/users/${var.username}"
  data_json = jsonencode({
    password = var.password
    policies = [vault_policy.namespace_policy.name]
  })
  namespace = vault_namespace.namespace.path
  depends_on = [vault_auth_backend.userpass, vault_policy.namespace_policy]
}
resource "vault_generic_endpoint" "admin_user" {
  path = "auth/userpass/users/admin"
  data_json = jsonencode({
    password = var.admin_password
    policies = ["admin-policy"]
  })
  namespace = vault_namespace.namespace.path
  depends_on = [vault_auth_backend.userpass, vault_policy.admin_policy]
}