variable "VPC-name" {
  description = "The name of the VPC"
  default     = "SAP-VPC"
}

variable "VPC-cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.65.0.0/16"
}

variable "region" {
  description = "The AWS region to deploy resources."
  default     = "eu-central-1"
}
