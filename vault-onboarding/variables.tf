variable "vault_address" {
  description = "The address of the Vault server"
  type        = string
}

variable "vault_token" {
  description = "The token to authenticate with Vault"
  type        = string
}

variable "namespace" {
  description = "The name of the namespace to create"
  type        = string
}

variable "username" {
  description = "The username for the static credentials"
  type        = string
}

variable "password" {
  description = "The password for the static credentials"
  type        = string
}
