### This module:
- creates an EC2 instance with latest Amazon Linux 2023
- in default VPC
- with public IP
- allows your current IP to SSH to this instance (so Terraform Cloud will not do it correctly)
- creates an IAM role with full S3 permissions
- installs Java with user data

It should be used only to download and upload SAP binaries FAST.

Afterwards, destroy it.