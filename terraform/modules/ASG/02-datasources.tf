data "template_file" "node" {
  template = "${file("${path.module}/Userdata/userdata.sh")}"

  vars {
    s3bucketid = "${var.bucketname}"
  }
}

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# These details were found in this command:
# aws ec2 describe-images --owners amazon --filters "Name=virtualization-type, Values=hvm" "Name=image-id, Values=ami-70edb016"

