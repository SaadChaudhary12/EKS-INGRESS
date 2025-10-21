terraform {
  required_version = ">= 1.10"

  backend "s3" {
    bucket = "saad-terraform-bucket"
    key    = "EKS-INGRESS/module/vpc/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}