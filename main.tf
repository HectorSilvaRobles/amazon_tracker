terraform {
 required_providers {
   aws = {
     source = "hashicorp/aws"
   }
 }
}
    
provider "aws" {
  region = "us-west-1"
  shared_credentials_files = ["$HOME/.aws/credentials"]
}


## IAM Role + Policy
resource "aws_iam_role" "iam_amazon_batch_lambda_role" {
    name = "iam_amazon_batch_lambda_role"

    assume_role_policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
            {
            "Effect" : "Allow",
            "Principal" : {
                "Service" : "lambda.amazonaws.com"
            },
            "Action" : "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_role_policy" "amazon_batch_lambda_policy" {
  name = "amazon_batch_lambda_policy"
  role = aws_iam_role.iam_amazon_batch_lambda_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:*",
            ],
            "Resource": "${aws_dynamodb_table.amazon_seller_batch_table.arn}"
        }
    ]
  })
}