# Vault Onboarding Module README
## Overview

This module sets up a namespace in Vault, creates a static K/V mount, and generates static credentials for accessing the namespace. It also defines policies for different levels of access within the namespace.
Usage

To use this module, you need to provide the Vault address, admin token, namespace, and credentials. The module will create the namespace, K/V mount, and the necessary policies.
### Variables

    vault_address: The address of the Vault server.
    vault_token: The token for the Vault server.
    namespace: The namespace to be created.
    username: The username for static credentials.
    password: The password for static credentials (sensitive).
    admin_password: The password for the admin user (sensitive).

### Outputs

    namespace: The namespace created for the Vault onboarding.
    username: The username for Vault onboarding.
    password: The password for Vault onboarding (sensitive).
    admin_password: The admin password for Vault onboarding (sensitive).
    onboarding_complete: Indicator that the onboarding process is complete.

Policies

    Namespace Policy: Allows read/write access to secrets within specific paths in the namespace.
    Admin Policy: Allows full access to the namespace and system backend but does not allow access to secret values.
