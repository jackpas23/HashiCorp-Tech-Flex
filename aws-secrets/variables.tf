variable "vault_address" {
  description = "Address of the Vault server"
  type        = string
}

variable "vault_token" {
  description = "Token for the Vault server"
  type        = string
}

variable "aws_backend_path" {
  description = "Path where the AWS backend will be mounted"
  type        = string
  default     = "aws"
}

variable "aws_access_key" {
  description = "The AWS Access Key ID for the secrets engine"
  type        = string
}

variable "aws_secret_key" {
  description = "The AWS Secret Key for the secrets engine"
  type        = string
}

variable "aws_region" {
  description = "The AWS region for API calls"
  type        = string
  default     = "us-east-1"
}

variable "role_name" {
  description = "Name of the role to be created in the secrets engine"
  type        = string
}

variable "policy_name" {
  description = "Name of the policy to be created for the team"
  type        = string
}
