provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}

module "vault_onboarding" {
  source        = "../vault-onboarding"
  vault_address = var.vault_address
  vault_token   = var.vault_token
  namespace     = "example-snamespace"
  username      = "example-user"
  password      = "example-password"
}

variable "vault_address" {
  description = "The address of the Vault server"
  type        = string
  #default     = "https://vault.example.com"
}

variable "vault_token" {
  description = "The token to authenticate with Vault"
  type        = string
  #default     = ""  # Optional default value
}