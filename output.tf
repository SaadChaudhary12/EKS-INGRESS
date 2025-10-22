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
