variable "region" {}

variable "awsprofile" {}

variable "vpcname" {}

variable "availability_zones" {
  type = "list"
}

#VPC Networking
variable "vpc_cidr" {}

#2 Private subnets
variable "private1_cidr" {}

variable "private2_cidr" {}

#2 Public subnets
variable "public1_cidr" {}

variable "public2_cidr" {}
