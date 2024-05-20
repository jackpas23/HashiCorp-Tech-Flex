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
