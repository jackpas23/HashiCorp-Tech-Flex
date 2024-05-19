provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}

resource "vault_namespace" "namespace" {
  path = var.namespace
  
}

resource "vault_mount" "kv" {
  path        = "secret"
  type        = "kv-v2"
  description = "Key-Value storage for static secrets"
  namespace   = vault_namespace.namespace.path
  depends_on  = [vault_namespace.namespace]
}

resource "vault_generic_endpoint" "dev_secret" {
  path = "secret/data/dev"
  data_json = jsonencode({
    data = {
      username = var.username
      password = var.password
    }
  })
  namespace  = vault_namespace.namespace.path
  depends_on = [vault_mount.kv]
}

resource "vault_generic_endpoint" "aws_dev_secret" {
  path = "secret/data/aws/dev"
  data_json = jsonencode({
    data = {
      username = var.username
      password = var.password
    }
  })
  namespace  = vault_namespace.namespace.path
  depends_on = [vault_mount.kv]
}

resource "vault_generic_endpoint" "azure_dev_secret" {
  path = "secret/data/azure/dev"
  data_json = jsonencode({
    data = {
      username = var.username
      password = var.password
    }
  })
  namespace  = vault_namespace.namespace.path
  depends_on = [vault_mount.kv]
}

resource "vault_policy" "namespace_policy" {
  name = "namespace-policy"
  policy = <<EOT
path "secret/data/dev" {
  capabilities = ["read", "create", "update", "delete", "list"]
}

path "secret/data/aws/dev" {
  capabilities = ["read", "create", "update", "delete", "list"]
}

path "secret/data/azure/dev" {
  capabilities = ["read", "create", "update", "delete", "list"]
}
EOT
  namespace  = vault_namespace.namespace.path
  depends_on = [vault_mount.kv]
}

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