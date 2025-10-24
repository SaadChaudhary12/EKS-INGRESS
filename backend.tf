################################################################################
# Backend
################################################################################

terraform {
  backend "s3" {
    bucket         = "saad-terraform-bucket1"
    key            = "EKS-INGRESS/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}

