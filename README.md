# Linux Terraform Vault Project 

Welcome to the Terraform configuration for setting up a Vault cluster using two custom modules. This guide will help you understand how my project is structured and how to get your own instance running.

## Project Structure

The project is divided into two main directories:

- **Root Directory**: This directory holds the primary Terraform configuration files that set up the overall infrastructure.
- **Modules Directory**: This directory contains reusable Terraform modules, specifically for onboarding and setting up the AWS secrets engine.

## Table of Contents

1. [Project Structure](#project-structure)
2. [Dependencies](#dependencies)
3. [Setup and Usage](#setup-and-usage)
4. [Modules](#modules)
    - [Vault Onboarding Module](#vault-onboarding-module)
    - [AWS Secrets Engine Module](#aws-secrets-engine-module)
5. [Policies](#policies)
    - [Namespace Policy](#namespace-policy)
    - [Admin Policy](#admin-policy)
    - [Application Policy](#application-policy)
    - [User Policy](#user-policy)
6. [Variable Definitions](#variable-definitions)
7. [Outputs](#outputs)
## Dependencies

To run this project, you need the following dependencies:

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0 or later)
- AWS account with access keys (account needs to allow IAM provisioning eg. Admin)
- HashiCorp Cloud Platform (HCP) credentials

## Setup and Usage
Make sure you have terraform & HCP installed on your linux distro.
```
sudo apt-get install terraform && sudo apt-get install hcp
```
### Step 1: Clone the Repository

```sh
#setup script assumes you have terraform installed
git clone https://github.com/jackpas23/HashiCorp-Tech-Flex.git
cd your-repo
./setup.sh
```

### Step 2: Initialize and Apply Terraform Configuration

The `setup.sh` script will prompt you for the necessary inputs, export the required environment variables, initialize Terraform, and apply the configuration. 

### Step 3: Accessing The Vault

after the setup.sh script has finished executing, the terminal output will provide you with the new cluster address and admin token.

## Modules

### Root Module

The root module sets up the overall infrastructure using HCP and orchestrates the onboarding and AWS Secrets Engine modules.

### Vault Onboarding Module

This module sets up a namespace, a static K/V mount, and generates static credentials for access to the namespace. It also creates a user and admin policy for the namespace.

#### Example Usage

```hcl
module "vault_onboarding" {
  source        = "./modules/vault-onboarding"
  vault_address = hcp_vault_cluster.hcp_vault_cluster.vault_public_endpoint_url
  vault_token   = hcp_vault_cluster_admin_token.vault_admin.token
  namespace     = var.namespace
  username      = var.username
  password      = var.password
  admin_password = var.admin_password  
}
```

### AWS Secrets Engine Module

This module sets up the AWS Secrets Engine in Vault, allowing the team to generate dynamic credentials for AWS. It creates necessary roles and policies for user and application access.

#### Example Usage

```hcl
module "aws_secrets_engine" {
  source  = "./modules/aws-secrets"
  vault_address = hcp_vault_cluster.hcp_vault_cluster.vault_public_endpoint_url
  vault_token   = hcp_vault_cluster_admin_token.vault_admin.token
  aws_backend_path = var.aws_backend_path
  aws_access_key   = var.aws_access_key
  aws_secret_key   = var.aws_secret_key
  aws_region       = var.aws_region
  role_name        = var.role_name
  user_policy_name = var.user_policy_name
  app_policy_name  = var.app_policy_name
  namespace =  module.vault_onboarding.namespace
}
```

## Policies

### Namespace Policy 
The namespace policy allows read/write access to secrets at /secret/data/dev, /secret/data/aws/dev, and /secret/data/azure/dev but does not allow access to other areas of the namespace.

```hcl
resource "vault_policy" "namespace_policy" {
  name = "dev-user"
  policy = <<EOT
path "secret/data/dev" {
  capabilities = ["read", "create", "update", "delete", "list"]
}

path "secret/data/aws/dev" {
  capabilities = ["read", "create", "update", "delete", "list"]
}

path "secret/data/azure/dev" {
  capabilities = ["read", "create", "update", "delete", "list"]
}
EOT
  namespace  = vault_namespace.namespace.path
  depends_on = [vault_mount.kv]
}
```
### Admin Policy

The admin policy allows full access to the namespace and the system backend, but it does not allow access to secret values.

```hcl
resource "vault_policy" "admin_policy" {
  name = "dev-admin"
  policy = <<EOT
# List and read metadata for all paths
path "secret/metadata/*" {
  capabilities = ["list", "read"]
}

path "secret/data/*" {
  capabilities = ["list"]
}

# Grant similar capabilities for system and auth paths
path "sys/*" {
  capabilities = ["list", "read"]
}

path "auth/*" {
  capabilities = ["list", "read"]
}
EOT
  namespace  = vault_namespace.namespace.path
}
```

### Application Policy 

The application policy allows read access to both keys and values within the specified paths.

```hcl
resource "vault_policy" "aws_application_policy" {
  name      = var.app_policy_name
  namespace = var.namespace

  policy = <<EOT
path "${var.aws_backend_path}/creds/${var.role_name}" {
  capabilities = ["read", "list"]
}
EOT
}
```

### User Policy 

The user policy allows users to create, update, delete, and list keys, but they cannot read the values.

```hcl
resource "vault_policy" "aws_user_policy" {
  name      = var.user_policy_name
  namespace = var.namespace

  policy = <<EOT
path "${var.aws_backend_path}/creds/${var.role_name}" {
  capabilities = ["create", "update", "delete", "list"]
}
EOT
}
```

## Variable Definitions

### Root Module Variables

- `vault_address`: Address of the Vault server.
- `vault_admin_token`: Admin token for Vault.
- `namespace`: The namespace for Vault resources.
- `aws_access_key`: The AWS Access Key ID for the secrets engine.
- `aws_secret_key`: The AWS Secret Key for the secrets engine.
- `aws_region`: The AWS region for API calls.
- `role_name`: Name of the role to be created in the secrets engine.
- `users`: List of users for whom to create policies.
- `user_policy_name_prefix`: Prefix for user policy names.
- `app_policy_name`: Name of the policy to be created for applications.
- `username`: The username for Vault onboarding.
- `password`: The password for Vault onboarding.
- `admin_password`: The password for the admin user.

## Outputs

### Root Module
- `vault_address`: The address of the Vault cluster.
- `vault_token`: The inital admin access token used to access root namespace.
### Vault Onboarding Module

- `namespace`: The namespace created for the Vault onboarding.
- `username`: The username for Vault onboarding.
- `password`: The password for Vault onboarding (sensitive).
- `admin_password`: The admin password for Vault onboarding (sensitive).
- `onboarding_complete`: Indicator that the onboarding process is complete.

