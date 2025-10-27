variable "cluster_name" {}
variable "vpc_id" {}
variable "region" {}
variable "cluster_endpoint" {}
variable "cluster_ca_data" {}

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