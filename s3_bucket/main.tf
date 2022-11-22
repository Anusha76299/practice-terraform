resource "aws_s3_bucket" "mybucket-1" {
  bucket = "ansible-devops-anusha"
  tags = {
    Name        = "Mybucket1"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.mybucket-1.id
  acl    = "private"
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.mybucket-1.id
  key    = "test2"
  source = "../../../test2.txt"
  etag = md5("../../../test2.txt")
}

resource "aws_s3_bucket_object" "object1" {
  bucket = aws_s3_bucket.mybucket-1.id
  acl = "private"
  key    = "${var.named_folder}/"
}

resource "aws_s3_bucket_object" "object2" {
  bucket = aws_s3_bucket.mybucket-1.id
  for_each = fileset("../../../text1","*")
  acl = "private"
  key    = "${var.named_folder}/${each.value}"
  source = "../../../text1/${each.value}"
  etag = md5("../../../text1/${each.value}")
}