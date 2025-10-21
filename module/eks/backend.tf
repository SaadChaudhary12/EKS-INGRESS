terraform {
  required_version = ">= 1.10"

  backend "s3" {
    bucket = "saad-terraform-bucket"
    key    = "EKS-INGRESS/eks/terraform.tfstate"
    region = "us-west-1"
    encrypt = true
  }
}