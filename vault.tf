terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.27.0"  # Adjust the version as necessary
    }
  }
}

provider "hcp" {
  client_id     = var.HCP_CLIENT_ID
  client_secret = var.HCP_CLIENT_SECRET
}

// Create a HashiCorp Virtual Network (HVN).
resource "hcp_hvn" "example" {
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
  cidr_block     = "172.25.16.0/20"
}

// Create a Vault cluster within the HVN.
resource "hcp_vault_cluster" "example" {
  cluster_id = var.cluster_id
  hvn_id     = hcp_hvn.example.hvn_id
  tier       = var.tier
  # public_endpoint = true
}
