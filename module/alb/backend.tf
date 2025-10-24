terraform {
  required_version = ">= 1.10"

  backend "s3" {
    bucket = "saad-terraform-bucket1"
    key    = "EKS-INGRESS/alb/terraform.tfstate"
    region = "us-eastt-2"
    encrypt = true
  }
}