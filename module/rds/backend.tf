terraform {
  required_version = ">= 1.10"

  backend "s3" {
    bucket = "saad-terraform-bucket1"
    key    = "EKS-INGRESS/rds/terraform.tfstate"
    region = "us-east-2"
    encrypt = true
  }
}