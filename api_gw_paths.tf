## /batch
resource "aws_api_gateway_resource" "api_gw_batch_path" {
  rest_api_id = aws_api_gateway_rest_api.api_gw_amazon_batch.id
  parent_id   = aws_api_gateway_rest_api.api_gw_amazon_batch.root_resource_id
  path_part   = "batch"
}

## /batch/item
resource "aws_api_gateway_resource" "api_gw_batch_item_path" {
  rest_api_id = aws_api_gateway_rest_api.api_gw_amazon_batch.id
  parent_id   = aws_api_gateway_resource.api_gw_batch_path.id
  path_part   = "item"
}
