provider "aws" {
  region  = "${var.region}"
  profile = "${var.awsprofile}"
}

data "aws_availability_zones" "available" {}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

module vpc {
  source             = "./modules/VPC"
  availability_zones = ["${data.aws_availability_zones.available.names[0]}", "${data.aws_availability_zones.available.names[1]}"]
  region             = "${var.region}"
  awsprofile         = "${var.awsprofile}"
  vpcname            = "${var.vpcname}"
  private1_cidr      = "${var.private1_cidr}"
  private2_cidr      = "${var.private2_cidr}"
  public1_cidr       = "${var.public1_cidr}"
  public2_cidr       = "${var.public2_cidr}"
  vpc_cidr           = "${var.vpc_cidr}"
}

module "asg" {
  source             = "./modules/ASG"
  availability_zones = ["${data.aws_availability_zones.available.names[0]}", "${data.aws_availability_zones.available.names[1]}"]
  lc_name            = "${var.lc_name}"
  bucketname         = "${var.s3bucketname}"
  instance_type      = "${var.instance_size}"
  security_groups    = "${module.security.secgroup}"
  subnets            = ["${module.vpc.aws_subnet.public1.id}", "${module.vpc.aws_subnet.public2.id}"]
  key_name           = "${var.key_name}"
  master_elb         = "${module.elb.elb_name}"
}

module "security" {
  source = "./modules/SecurityGroups"
  vpcid  = "${module.vpc.aws_vpc.id}"
}

module "elb" {
  source          = "./modules/ELB"
  instance_name   = "${var.instance_name}"
  subnets         = ["${module.vpc.aws_subnet.public1.id}", "${module.vpc.aws_subnet.public2.id}"]
  security_groups = "${module.security.secgroup}"
  region          = "${var.region}"
}

module "s3" {
  source     = "./modules/S3"
  bucketname = "${var.s3bucketname}"
}
