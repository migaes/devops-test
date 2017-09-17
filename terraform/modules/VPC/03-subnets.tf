resource "aws_subnet" "public1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public1_cidr}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zones[0]}"

  tags {
    Name = "${var.vpcname}"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public2_cidr}"
  map_public_ip_on_launch = true
  availability_zone       = "${var.availability_zones[1]}"

  tags {
    Name = "${var.vpcname}"
  }
}

# Create the 2 private subnets to launch instances into

resource "aws_subnet" "private1" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.private1_cidr}"
  availability_zone = "${var.availability_zones[0]}"

  tags = {
    Name = "${var.vpcname}"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.private2_cidr}"
  availability_zone = "${var.availability_zones[1]}"

  tags = {
    Name = "${var.vpcname}"
  }
}

# Associate public subnets to public route tables

resource "aws_route_table_association" "public_association1" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.public1_route_table.id}"
}

resource "aws_route_table_association" "public_association2" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.public2_route_table.id}"
}

# Associate private subnets to private route tables
resource "aws_route_table_association" "private_association1" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.private1_route_table.id}"
}

resource "aws_route_table_association" "private_association2" {
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.private2_route_table.id}"
}
