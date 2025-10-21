variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_version" {
  type        = string
  default     = "1.31"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for EKS cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for EKS cluster and node group"
}

variable "node_group_name" {
  type        = string
  description = "EKS managed node group name"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
}

variable "capacity_type" {
  type        = string
  default     = "ON_DEMAND"
}

variable "min_size" {
  type        = number
  default     = 1
}

variable "max_size" {
  type        = number
  default     = 2
}

variable "desired_size" {
  type        = number
  default     = 1
}

variable "tags" {
  type        = map(string)
  default     = {}
}

