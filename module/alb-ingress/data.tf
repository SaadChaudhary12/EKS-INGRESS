data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "saad-terraform-bucket1"
    key    = "EKS-INGRESS/terraform.tfstate"
    region = "us-east-2"
  }
}