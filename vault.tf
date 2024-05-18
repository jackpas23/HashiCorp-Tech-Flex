
# HCP provider allows authentication through HCP##
provider "hcp"{}

provider "aws" {
  region = var.region
  }
provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}

#resource "hcp_service_principal" "example" {
#  name = "vault-setup-sp"
  #role = "contributor"
#}

resource "hcp_hvn" "learn_hcp_vault_hvn" {
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
}

resource "hcp_vault_cluster" "learn_hcp_vault" {
  hvn_id     = hcp_hvn.learn_hcp_vault_hvn.hvn_id
  cluster_id = var.cluster_id
  tier = var.tier
  public_endpoint = true
}

output "vault_address" {
  description = "The address of the Vault server"
  value = var.vault_address
}
output "vault_token" {
  description = "The token to authenticate with Vault"
  value       = var.vault_token
  sensitive   = true
}