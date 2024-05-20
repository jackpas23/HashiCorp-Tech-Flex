resource "vault_policy" "team_policy" {
  name = var.policy_name
  namespace = var.namespace

  policy = <<EOT
path "${var.aws_backend_path}/creds/${var.role_name}" {
  capabilities = ["read"]
}
EOT
}