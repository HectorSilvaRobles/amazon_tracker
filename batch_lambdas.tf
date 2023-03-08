resource "aws_lambda_function" "amazon_batch_post_function" {
  filename      = "./functions/POST/post_lambda.zip"
  function_name = "amazon_batch_post_function"
  role          = aws_iam_role.iam_amazon_batch_lambda_role.arn
  handler       = "post_function.handler"
  runtime       = var.lambda_runtime

  environment {
    variables = {
      DB_TABLE_NAME = var.db_name
    }
  }
}

resource "aws_lambda_permission" "amazon_batch_post_lambda_apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.amazon_batch_post_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api_gw_amazon_batch.execution_arn}/*/*"
}
