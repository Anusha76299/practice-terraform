resource "aws_s3_bucket" "demos3" {
    bucket = "${var.bucket_name}"    
}

resource "aws_s3_bucket_acl" "acl" {
    bucket = aws_s3_bucket.demos3.id
    acl = "public-read"
}
