provider "aws" {
   region = "us-east-1"
}

resource "aws_dynamodb_table" "tfm_lock" {
  name = "terraform-lock"
  read_capacity  = 3
  write_capacity = 3
  hash_key       = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }
}
