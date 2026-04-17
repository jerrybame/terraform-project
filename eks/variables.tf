variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-group-sand"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.29"
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = "eks-group-sand-nodegroup"
}

variable "node_instance_type" {
  description = "EC2 instance type for the node group"
  type        = string
  default     = "t3.medium"
}

variable "desired_nodes" {
  description = "Desired number of nodes in the node group"
  type        = number
  default     = 2
}

variable "min_nodes" {
  description = "Minimum number of nodes in the node group"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Maximum number of nodes in the node group"
  type        = number
  default     = 3
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "sandbox"
}
