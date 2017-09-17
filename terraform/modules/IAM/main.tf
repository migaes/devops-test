resource "aws_iam_role" "perkbox_instance" {
  name               = "${var.perkbox_role_name}"
  path               = "/"
  assume_role_policy = "${file("${path.module}/Files/perkbox-role.json")}"
}

data "template_file" "perkbox_policy" {
  template = "${file("${path.module}/Files/perkbox-policy.json")}"

  vars {
    s3bucketname = "${var.bucketname}"
  }
}

resource "aws_iam_role_policy" "perkbox_instance_policy" {
  name   = "perkbox_policy"
  role   = "${aws_iam_role.perkbox_instance.id}"
  policy = "${data.template_file.perkbox_policy.rendered}"
}

resource "aws_iam_instance_profile" "perkbox_instance_profile" {
  depends_on = ["aws_iam_role.perkbox_instance", "aws_iam_role_policy.perkbox_instance_policy"]
  name       = "perkbox_profile"
  role       = "${aws_iam_role.perkbox_instance.name}"
}
