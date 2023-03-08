resource "aws_dynamodb_table" "amazon_seller_batch_table" {
  name = "amazon_seller_batch_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "guid"
  
  attribute {
    name = "guid"
    type = "S"
  }
}