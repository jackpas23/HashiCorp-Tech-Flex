##requirements section###
##requirement logged into hcp on browser####

# Log in to Terraform
{ echo "yes"; read -p "Enter your Terraform Cloud API key: " api_key; echo "$api_key"; } | terraform login 

hcp auth login
#sleep(3)
# Create the service principal and capture the output
#output=$(hcp iam service-principals keys create vault-setup-sp)

# Extract Client ID and Client Secret
#CLIENT_ID=$(echo "$output" | grep 'Client ID:' | awk '{print $3}')
#CLIENT_SECRET=$(echo "$output" | grep 'Client Secret:' | awk '{print $3}')

# Print Client ID and Client Secret
#echo "Client ID: $CLIENT_ID"
#echo "Client Secret: $CLIENT_SECRET"

#!/bin/bash

# Step 1: Initialize and apply the root Terraform configuration
terraform init
echo "yes" | terraform apply

# Step 2: Capture the outputs
envars=$(terraform output -json)

# Step 3: Extract the vault address and token from the outputs
vault_address=$(echo "$envars" | jq -r .vault_address.value)
vault_token=$(echo "$envars" | jq -r .vault_token.value)

# Step 4: Print the values (for debugging purposes)
echo "VAULT_ADDR: $vault_address"
echo "VAULT_TOKEN: $vault_token"

# Step 5: Initialize and apply the configuration in the vault_setup directory
terraform -chdir=vault_setup init
echo "yes" | terraform -chdir=vault_setup apply -var "vault_address=$vault_address" -var "vault_token=$vault_token"

# Initialize and apply Terraform
