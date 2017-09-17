variable "region" {}

variable "awsprofile" {}

variable "instance_size" {}

variable "instance_name" {}

variable "key_name" {}

# Bucket
variable "s3bucketname" {}

#VPC Networking
variable "vpc_cidr" {}

variable "vpcname" {}

#2 Private subnets
variable "private1_cidr" {}

variable "private2_cidr" {}

#2 Public subnets
variable "public1_cidr" {}

variable "public2_cidr" {}

### Autoscaling groups

variable "lc_name" {}
