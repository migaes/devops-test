resource "aws_autoscaling_group" "group1" {
  depends_on = ["aws_launch_configuration.launch_config1"]
  name       = "${var.lc_name}"

  availability_zones  = ["${var.availability_zones}"]
  vpc_zone_identifier = ["${var.subnets}"]

  launch_configuration = "${aws_launch_configuration.launch_config1.id}"

  max_size                  = "${var.asg_maximum_number_of_instances}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  desired_capacity          = "${var.asg_number_of_instances}"
  health_check_grace_period = "${var.health_check_grace_period}"
  default_cooldown          = "${var.default_cooldown}"
  health_check_type         = "${var.health_check_type}"
  load_balancers            = ["${var.master_elb}"]

  tag {
    key                 = "Name"
    value               = "${var.lc_name}"
    propagate_at_launch = true
  }
}
