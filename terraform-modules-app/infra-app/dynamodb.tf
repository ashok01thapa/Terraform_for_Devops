resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${var.env}-infra-app-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash.key

  attribute {
    name = var.hash.key
    type = "S"
  }

  
  tags = {
    Name        = "${var.env}-infra-app-table"
    Environment = var.env
  }
}