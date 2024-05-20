#!/bin/bash

# Prompt the user for input
read -p "Enter the Vault address (vault_address): " vault_address
read -p "Enter the Vault admin token (vault_admin_token): " vault_admin_token
read -p "Enter the namespace (namespace): " namespace
read -p "Enter the AWS Access Key ID (aws_access_key): " aws_access_key
read -sp "Enter the AWS Secret Key (aws_secret_key): " aws_secret_key
echo
read -p "Enter the AWS region (aws_region) [default: us-east-1]: " aws_region
aws_region=${aws_region:-us-east-1}
read -p "Enter the role name (role_name): " role_name
read -p "Enter the user policy name (user_policy_name): " user_policy_name
read -p "Enter the application policy name (app_policy_name): " app_policy_name
read -p "Enter the username (username): " username
read -sp "Enter the password (password): " password
echo
read -sp "Enter the admin password (admin_password): " admin_password
echo

# Export the environment variables
export TF_VAR_vault_address="$vault_address"
export TF_VAR_vault_admin_token="$vault_admin_token"
export TF_VAR_namespace="$namespace"
export TF_VAR_aws_access_key="$aws_access_key"
export TF_VAR_aws_secret_key="$aws_secret_key"
export TF_VAR_aws_region="$aws_region"
export TF_VAR_role_name="$role_name"
export TF_VAR_user_policy_name="$user_policy_name"
export TF_VAR_app_policy_name="$app_policy_name"
export TF_VAR_username="$username"
export TF_VAR_password="$password"
export TF_VAR_admin_password="$admin_password"

# Confirm and print the exported variables
echo "The following environment variables have been set:"
echo "TF_VAR_vault_address=$TF_VAR_vault_address"
echo "TF_VAR_vault_admin_token=$TF_VAR_vault_admin_token"
echo "TF_VAR_namespace=$TF_VAR_namespace"
echo "TF_VAR_aws_access_key=$TF_VAR_aws_access_key"
echo "TF_VAR_aws_secret_key=********"  # Do not print secret keys
echo "TF_VAR_aws_region=$TF_VAR_aws_region"
echo "TF_VAR_role_name=$TF_VAR_role_name"
echo "TF_VAR_user_policy_name=$TF_VAR_user_policy_name"
echo "TF_VAR_app_policy_name=$TF_VAR_app_policy_name"
echo "TF_VAR_username=$TF_VAR_username"
echo "TF_VAR_password=********"  # Do not print passwords
echo "TF_VAR_admin_password=********"  # Do not print passwords

# Optionally, you can run Terraform commands here if desired
 terraform init
 terraform plan
 terraform apply

