variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "cluster_name" {
  type    = string
  default = "eks-group-one"
}

variable "kubernetes_version" {
  type    = string
  default = "1.35"
}

variable "environment" {
  type    = string
  default = "sandbox"
}
