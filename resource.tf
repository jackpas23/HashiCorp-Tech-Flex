
resource "hcp_hvn" "hcp_vault_hvn1" {
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
}
resource "hcp_vault_cluster" "hcp_vault_cluster1" {
  hvn_id          = hcp_hvn.hcp_vault_hvn1.hvn_id
  cluster_id      = var.cluster_id
  tier            = var.tier
  public_endpoint = true
}
resource "hcp_vault_cluster_admin_token" "vault_admin" {
  cluster_id = hcp_vault_cluster.hcp_vault_cluster1.cluster_id
  depends_on = [hcp_vault_cluster.hcp_vault_cluster1]
}

module "vault_onboarding" {
  source        = "./vault-onboarding"
  vault_address = hcp_vault_cluster.hcp_vault_cluster1.vault_public_endpoint_url
  vault_token   = hcp_vault_cluster_admin_token.vault_admin.token
  namespace     = "example-namespace"
  username      = "example-user"
  password      = "example-password"
}