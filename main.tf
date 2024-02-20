terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.22.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.3.0"
    }
  }
}

variable "region" {
  description = "The AWS region to deploy resources."
  default     = "eu-central-1"
  # You need to upload huge packages to S3 so select somewhere close
}

provider "aws" {
  region = var.region
}
