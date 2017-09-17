resource "aws_s3_bucket" "perkboxbucket" {
  bucket = "${var.bucketname}"
  acl    = "public-read"

  tags {
    Name        = "${var.bucketname}"
    Environment = "Perkbox"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.perkboxbucket.id}"
  key    = "helloworld"
  source = "${path.module}/Uploads/helloworld.txt"
  etag   = "${md5(file("${path.module}/Uploads/helloworld.txt"))}"
}
