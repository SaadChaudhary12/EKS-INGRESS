################################################################################
# Outputs
################################################################################

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_ids
}

output "public_subnets" {
  value = module.vpc.public_ids
}

output "endpoint" {
  value = module.rds.endpoint
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_group_name" {
  value = module.eks.node_group_name
}

output "cluster_role_arn" {
  value = module.eks.cluster_role_arn
}

output "oidc_provider_url" {
  value = module.eks.oidc_provider_url
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "cluster_ca_data" {
  value = module.eks.cluster_ca_data
}