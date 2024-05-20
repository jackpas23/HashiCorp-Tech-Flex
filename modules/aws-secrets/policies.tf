resource "vault_policy" "aws_user_policy" {
  name      = var.user_policy_name
  namespace = var.namespace

  policy = <<EOT
path "${var.aws_backend_path}/creds/${var.role_name}" {
  capabilities = ["create", "update", "delete", "list"]
}
EOT
}

resource "vault_policy" "aws_application_policy" {
  name      = var.app_policy_name
  namespace = var.namespace

  policy = <<EOT
path "${var.aws_backend_path}/creds/${var.role_name}" {
  capabilities = ["read", "list"]
}
EOT
}