resource "vault_aws_secret_backend" "aws" {
  path       = var.aws_backend_path
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
  namespace  = var.namespace
}

resource "vault_aws_secret_backend_role" "role" {
  backend = vault_aws_secret_backend.aws.path
  name    = var.role_name

  credential_type = "iam_user"
  policy_document = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "iam:*",
        "s3:*",
        "sts:*"
      ],
      "Resource": "*"
    }
  ]
}
EOT
}