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

provider "aws" {
  region = "eu-central-1"
  # You need to upload huge packages to S3 so select somewhere close
}
