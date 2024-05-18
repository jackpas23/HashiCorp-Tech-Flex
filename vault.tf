terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.27.0" # Adjust the version as necessary
    }
  }
}

provider "hcp" {
  // Configure the HCP provider if necessary
}

resource "hcp_hvn" "learn_hcp_vault_hvn" {
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
}

resource "hcp_vault_cluster" "learn_hcp_vault" {
  hvn_id     = hcp_hvn.learn_hcp_vault_hvn.hvn_id
  cluster_id = var.cluster_id
  tier       = var.tier
  # public_endpoint = true
}
