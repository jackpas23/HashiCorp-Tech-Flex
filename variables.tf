variable "hvn_id" {
  description = "The ID of the HCP HVN."
  type        = string
  default     = "hcp-vault-hvn4"
}

variable "cluster_id" {
  description = "The ID of the Vault Dedicated cluster."
  type        = string
  default     = "hcp-vault-cluster4"
}

variable "route_id" {
  description = "The ID of the HCP HVN route."
  type        = string
  default     = "hvn-route4"
}

variable "region" {
  description = "The region of the HCP HVN and Vault cluster."
  type        = string
  default     = "us-east-1"
}

variable "cloud_provider" {
  description = "The cloud provider of the HCP HVN and Vault cluster."
  type        = string
  default     = "aws"
}

variable "tier" {
  description = "Tier of the Vault Dedicated cluster. Valid options for tiers."
  type        = string
  default     = "dev"
}

