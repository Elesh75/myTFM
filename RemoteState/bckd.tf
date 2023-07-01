resource "aws_s3_bucket" "s3_bucket" {
  bucket = "class31demo1"
}


resource "aws_s3_bucket_acl" "my_bucket" {
    bucket = "class31demo1"
    acl = "private"
}

resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}