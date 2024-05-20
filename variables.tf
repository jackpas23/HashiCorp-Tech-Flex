variable "hvn_id" {
  description = "The ID of the HCP HVN."
  type        = string
  default     = "hcp-vault-hvn1"
}

variable "cluster_id" {
  description = "The ID of the Vault Dedicated cluster."
  type        = string
  default     = "hcp-vault-cluster1"
}

variable "route_id" {
  description = "The ID of the HCP HVN route."
  type        = string
  default     = "hvn-route1"
}

variable "aws_region" {
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

variable "aws_access_key" {
  description = "The AWS Access Key ID for the secrets engine"
  type        = string
}

variable "aws_secret_key" {
  description = "The AWS Secret Key for the secrets engine"
  type        = string
  sensitive   = true
}

variable "username" {
  description = "The username for onboarding"
  type        = string
}

variable "password" {
  description = "The password for onboarding"
  type        = string
  sensitive = true
}
variable "admin_password" {
  description = "The password for the admin user"
  type        = string
  sensitive   = true
}
variable "namespace" {
  description = "The namespace in which to provision the resources"
  type        = string
  default = "dev"
}
variable "user_policy_name" {
  description = "ploicy name for uers in aws_secrets module"
  type        = string
  default     = "dev-aws-user"
}
variable "app_policy_name" {
  description = "ploicy name for applications in aws_secrets module"
  type        = string
  default     = "dev-aws-app"
}
variable "role_name" {
  description = "name of AWS user role"
  type        = string
  default     = "dev"
}
variable "aws_backend_path" {
  description = "Path where the AWS backend will be mounted"
  type        = string
  default     = "aws"
}