provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}

resource "vault_namespace" "namespace" {
  path = var.namespace
  
}