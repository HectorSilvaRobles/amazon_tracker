resource "aws_api_gateway_rest_api" "api_gw_amazon_batch" {
  name = "api_gw_amazon_batch"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api_gw_amazon_batch_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gw_amazon_batch.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.api_gw_batch_item_path.id,
      aws_api_gateway_resource.api_gw_batch_path.id,

      aws_api_gateway_method.batch_create_item_method.id,
      aws_api_gateway_integration.batch_create_item_integration.id
    ]))
  }

  depends_on = [
    aws_api_gateway_integration.batch_create_item_integration
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_gw_batch_stage" {
  deployment_id = aws_api_gateway_deployment.api_gw_amazon_batch_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gw_amazon_batch.id
  stage_name    = "prod"
}
