output "vault_address" {
  description = "The address of the Vault server"
  value       = hcp_vault_cluster.hcp_vault_cluster.vault_public_endpoint_url

}

output "vault_token" {
  description = "The token to authenticate with Vault"
  value       = hcp_vault_cluster_admin_token.vault_admin.token
  sensitive   = true
}