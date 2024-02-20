resource "random_string" "bucket-id" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "cf-templates" {
  bucket = "sap-cf-templates-${random_string.bucket-id.result}"
}

resource "aws_s3_bucket" "sap-packages" {
  bucket = "launchwizard-sap-packages-${random_string.bucket-id.result}"
}

output "sap_packages_bucket" {
  value = aws_s3_bucket.sap-packages.bucket
}
