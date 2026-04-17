variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "cluster_name" {
  type    = string
  default = "eks-group-sand"
}

variable "environment" {
  type    = string
  default = "sandbox"
}
