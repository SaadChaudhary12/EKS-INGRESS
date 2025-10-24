output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "node_group_name" {
  value = aws_eks_node_group.this.node_group_name
}

output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

# OIDC Provider URL
output "oidc_provider_url" {
  description = "OIDC issuer URL for the EKS cluster"
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

# OIDC Provider ARN
output "oidc_provider_arn" {
  description = "OIDC provider ARN associated with the EKS cluster"
  value       = aws_iam_openid_connect_provider.eks_oidc_provider.arn
}

# EKS cluster certificate authority data (base64)
output "cluster_ca_data" {
  description = "EKS cluster certificate authority data (base64 encoded)"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}
