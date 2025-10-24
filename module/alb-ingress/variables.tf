variable "cluster_name" {}
variable "vpc_id" {}
variable "region" {}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "oidc_provider_url" {
  type        = string
  description = "OIDC provider URL for EKS cluster"
}

variable "oidc_provider_arn" {
  type        = string
  description = "OIDC provider ARN for EKS cluster"
}