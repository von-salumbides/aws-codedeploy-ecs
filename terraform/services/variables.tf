variable "aws_account" {}
variable "project" {
  default = "devops"
}
variable "vpc" {
  default = "vpc"
}
variable "owner" {
  default = "devops"
}

variable "env" {
  default = "poc"
}

variable "region" {
  default = "us-east-2"
}

variable "cost_center" {
  default = "common"
}
variable "ecs_cluster_name" {
  default = ""
}
variable "subnet_list" {
  type = list(string)
  default = [
    "poc-1",
    "poc-2",
    "poc-3"
  ]
}