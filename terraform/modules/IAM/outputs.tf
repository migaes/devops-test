output "perkbox_instance_profile" {
  value = "${aws_iam_instance_profile.perkbox_instance_profile.id}"
}

output "perkbox_role_name" {
  value = "${var.perkbox_role_name}"
}
