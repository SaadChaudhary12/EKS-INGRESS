variable "cluster_name" {}
variable "vpc_id" {}
variable "region" {}
variable "oidc_provider_url" {}
variable "oidc_provider_arn" {}
variable "tags" {
  type    = map(string)
  default = {}
}
