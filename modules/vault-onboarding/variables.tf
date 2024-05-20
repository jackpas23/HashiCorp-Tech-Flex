variable "vault_address" {
  description = "The address of the Vault server"
  type        = string
}

variable "vault_token" {
  description = "The token to authenticate with Vault"
  type        = string
  sensitive   = true
}

variable "namespace" {
  description = "The namespace for the Vault configuration"
  type        = string
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