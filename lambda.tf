data "aws_iam_policy_document" "lamda-assume-role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam-test-lambda" {
  name               = "iam-test-lambda"
  assume_role_policy = data.aws_iam_policy_document.lamda-assume-role.json
}

resource aws_lambda_function "python-test-lambda" {
  function_name = "python-test-lambda"
  role          = aws_iam_role.iam-test-lambda.arn
  runtime       = "python3.12"
  handler       = "hello_world.lambda_handler"
  filename      = "./function/hello_world.zip"

}

resource "aws_lambda_function_url" "python-test-lambda-url" {
  function_name      = aws_lambda_function.python-test-lambda.function_name
  authorization_type = "NONE"
}