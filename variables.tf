variable "hvn_id" {
  description = "The ID of the HCP HVN."
  type        = string
  default     = "learn-hcp-vault-hvn"
}

variable "cluster_id" {
  description = "The ID of the Vault Dedicated cluster."
  type        = string
  default     = "learn-hcp-vault-cluster"
}

variable "region" {
  description = "The region of the HCP HVN and Vault cluster."
  type        = string
  default     = "us-west-2"
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
variable "HCP_CLIENT_ID" {
  description = "The HCP Client ID"
  type        = string
  sensitive   = true
}

variable "HCP_CLIENT_SECRET" {
  description = "The HCP Client Secret"
  type        = string
  sensitive   = true
}