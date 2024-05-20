provider "hcp" {}

provider "aws" {
  region = var.aws_region
}
provider "vault" {
  address = hcp_vault_cluster.hcp_vault_cluster.vault_public_endpoint_url
  token   = hcp_vault_cluster_admin_token.vault_admin.token

}
#no terrform config
