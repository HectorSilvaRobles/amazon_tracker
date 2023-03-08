resource "aws_lambda_function" "amazon_batch_post_function" {
    filename = "./functions/POST/post_lambda.zip"
    function_name = "amazon_batch_post_function"
    role = aws_iam_role.iam_amazon_batch_lambda_role.arn
    handler = "post_function.handler"
    runtime = var.lambda_runtime

    environment {
      variables = {
        DB_TABLE_NAME=var.db_name
      }
    }
}