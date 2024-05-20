# Terraform Vault AWS Secrets Engine Setup

Welcome to the Terraform configuration for setting up an AWS Secrets Engine in Vault using HashiCorp Cloud Platform (HCP). This project is designed for an interview to showcase your skills as a DevSecOps Engineer for HashiCorp Vault.

## Project Structure

The project is organized into two main directories:
- **Root Directory**: Contains the primary Terraform configuration files.
- **Modules Directory**: Contains reusable Terraform modules for onboarding and AWS secrets engine setup.

## Table of Contents

1. [Project Structure](#project-structure)
2. [Dependencies](#dependencies)
3. [Setup and Usage](#setup-and-usage)
4. [Modules](#modules)
    - [Vault Onboarding Module](#vault-onboarding-module)
    - [AWS Secrets Engine Module](#aws-secrets-engine-module)
5. [Variable Definitions](#variable-definitions)
6. [Outputs](#outputs)

## Dependencies

To run this project, you need the following dependencies:

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0 or later)
- Access to a Vault instance with admin privileges
- AWS account with access keys
- HashiCorp Cloud Platform (HCP) credentials

## Setup and Usage

### Step 1: Clone the Repository

```sh
git clone https://github.com/your-repo.git
cd your-repo
./setup.sh
```

### Step 2: Initialize and Apply Terraform Configuration

The setup.sh script will prompt you for the necessary inputs, export the required environment variables, initialize Terraform, and apply the configuration.



## Modules

### Vault Onboarding Module

This module sets up a namespace, static K/V mount, and generates static credentials for access to the namespace.

#### Example Usage

```hcl
module "vault_onboarding" {
  source = "./modules/vault-onboarding"
  vault_address = var.vault_address
  vault_token = var.vault_admin_token
  namespace = var.namespace
  username = var.username
  password = var.password
  admin_password = var.admin_password
}
```

### AWS Secrets Engine Module

This module sets up the AWS Secrets Engine in Vault, allowing the team to generate dynamic credentials for AWS.

#### Example Usage

```hcl
module "aws_secrets_engine" {
  source = "./modules/aws-secrets"
  vault_address = var.vault_address
  vault_token = var.vault_admin_token
  aws_backend_path = var.aws_backend_path
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  aws_region = var.aws_region
  role_name = var.role_name
  app_policy_name = var.app_policy_name
  namespace = module.vault_onboarding.namespace
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

### Vault Onboarding Module

- `namespace`: The namespace created for the Vault onboarding.

### AWS Secrets Engine Module

- `aws_user_policies`: List of user policies created for AWS.
- `aws_application_policy`: Policy created for applications in AWS.
