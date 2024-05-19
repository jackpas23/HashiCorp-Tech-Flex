
# HCP provider allows authentication through HCP##
provider "hcp"{}

provider "aws" {
  region = var.region
  }
provider "vault" {
  address = hcp_vault_cluster.hcp_vault_cluster4.vault_public_endpoint_url
  token   = hcp_vault_cluster_admin_token.vault_admin.token
  
}
resource "hcp_hvn" "hcp_vault_hvn4" {
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
}
resource "hcp_vault_cluster" "hcp_vault_cluster4" {
  hvn_id     = hcp_hvn.hcp_vault_hvn4.hvn_id
  cluster_id = var.cluster_id
  tier = var.tier
  public_endpoint = true
}
resource "hcp_vault_cluster_admin_token" "vault_admin" {
  cluster_id = hcp_vault_cluster.hcp_vault_cluster4.cluster_id
  depends_on = [hcp_vault_cluster.hcp_vault_cluster4]
}
output "vault_address" {
  description = "The address of the Vault server"
  value       = hcp_vault_cluster.hcp_vault_cluster4.vault_public_endpoint_url 
  
}

output "vault_token" {
  description = "The token to authenticate with Vault"
  value       = hcp_vault_cluster_admin_token.vault_admin.token
  sensitive = true
}
module "vault_onboarding" {
  source        = "./vault-onboarding"
  vault_address = hcp_vault_cluster.hcp_vault_cluster4.vault_public_endpoint_url
  vault_token   = hcp_vault_cluster_admin_token.vault_admin.token
  namespace     = "example-namespace"
  username      = "example-user"
  password      = "example-password"
}