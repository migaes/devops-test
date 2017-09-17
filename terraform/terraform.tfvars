region = "eu-west-2"

awsprofile = "default"

vpcname = "Perkboxvpc"

vpc_cidr = "10.0.0.0/16"

instance_size = "t2.micro"

instance_count = "1"

instance_name = "Perkbox-instance"

key_name = "perkboxkey"

# S3 Bucket
s3bucketname = "perkbox-devops-test-abs"

# 2 Private CIDRs
private1_cidr = "10.0.0.0/24"

private2_cidr = "10.0.1.0/24"

# 2 Public CIDRs
public1_cidr = "10.0.2.0/24"

public2_cidr = "10.0.3.0/24"

## Autoscaling groups

lc_name = "perkbox-lc"
