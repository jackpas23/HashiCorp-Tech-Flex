
resource "hcp_hvn" "hcp_vault_hvn1" {
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.aws_region
}
resource "hcp_vault_cluster" "hcp_vault_cluster" {
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
  source        = "./modules/vault-onboarding"
  vault_address = hcp_vault_cluster.hcp_vault_cluster1.vault_public_endpoint_url
  vault_token   = hcp_vault_cluster_admin_token.vault_admin.token
  namespace     = var.namespace
  username      = var.username
  password      = var.password
  admin_password = var.admin_password
}

module "aws_secrets_engine" {
  source  = "./modules/aws-secrets"
  vault_address = hcp_vault_cluster.hcp_vault_cluster1.vault_public_endpoint_url
  vault_token   = hcp_vault_cluster_admin_token.vault_admin.token
  aws_backend_path = var.aws_backend_path
  aws_access_key   = var.aws_access_key
  aws_secret_key   = var.aws_secret_key
  aws_region       = var.aws_region
  role_name        = var.role_name
  user_policy_name = var.user_policy_name
  app_policy_name  = var.app_policy_name
  namespace = var.namespace
}