resource "vault_policy" "namespace_policy" {
  name = "dev-user"
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

resource "vault_policy" "admin_policy" {
  name = "dev-admin"
  policy = <<EOT
# List and read metadata for all paths
path "secret/metadata/*" {
  capabilities = ["list", "read"]
}

path "secret/data/*" {
  capabilities = ["list"]
}

# Grant similar capabilities for system and auth paths
path "sys/*" {
  capabilities = ["list", "read"]
}

path "auth/*" {
  capabilities = ["list", "read"]
}

# Add more paths as needed for admin visibility
EOT
  namespace  = vault_namespace.namespace.path
}