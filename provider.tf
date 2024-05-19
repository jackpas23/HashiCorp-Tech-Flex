provider "hcp" {}

provider "aws" {
  region = var.region
}
provider "vault" {
  address = hcp_vault_cluster.hcp_vault_cluster1.vault_public_endpoint_url
  token   = hcp_vault_cluster_admin_token.vault_admin.token

}
terraform {
  backend "remote" {
    organization = "jackpas23-org"

    workspaces {
      name = "HashiCorp-Tech-Flex"
    }
  }
}