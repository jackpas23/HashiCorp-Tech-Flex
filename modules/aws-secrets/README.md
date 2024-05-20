# AWS Secrets Engine Module
## Overview

The AWS Secrets Engine module configures the AWS Secrets Engine in Vault, enabling the generation of dynamic AWS credentials. It creates necessary roles and policies for different access levels.
Usage

To use this module, provide the Vault address, admin token, AWS backend path, AWS credentials, and role information. The module will configure the AWS Secrets Engine and create the required policies.
Key Features

    AWS Secrets Engine Setup: Configures Vault to manage AWS credentials.
    Roles and Policies:
        AWS Secret Backend: Sets up the backend for managing AWS credentials.
        User Policy: Allows users to create, update, delete, and list keys without reading values.
        Application Policy: Allows applications to read keys and values.
