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

# Initialize and apply Terraform
terraform init
echo "yes" | terraform apply;
envars=$(terraform output -json)
terraform apply -var "vault_address=$(echo "$envars" | jq .vault_addr.value)" -var "vault_token=$(echo "$envars" | jq .vault_addr.value)"
#echo "VAULT_ADDR: $VAULT_ADDR"
#echo "VAULT_TOKEN: $VAULT_TOKEN
terraform -chdir=vault_setup init
echo "yes" | terraform -chdir=vault_setup apply
####HCP service prinicpal script 
