# data "terraform_remote_state" "vpc" {
#   backend = "s3"
#   config = {
#     bucket = "saad-terraform-bucket"
#     key    = "EKS-INGRESS/module/vpc/terraform.tfstate"
#     region = "us-east-1"
#   }
# }