### GET


### POST (Create Item) - /batch/item
resource "aws_api_gateway_method" "batch_create_item_method" {
  rest_api_id      = aws_api_gateway_rest_api.api_gw_amazon_batch.id
  resource_id      = aws_api_gateway_resource.api_gw_batch_item_path.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "batch_create_item_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gw_amazon_batch.id
  resource_id             = aws_api_gateway_resource.api_gw_batch_item_path.id
  http_method             = aws_api_gateway_method.batch_create_item_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.amazon_batch_post_function.invoke_arn
}
