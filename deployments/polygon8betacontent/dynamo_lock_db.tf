resource "aws_dynamodb_table" "dynamodb-lock-tfstate" {
  name = "lock-tfstate-polygon8betacontent"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "DynamoDB tfstate lock table"
  }
}
