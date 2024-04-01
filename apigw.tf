# Create API Gateway
resource "aws_apigatewayv2_api" "python-test-apigw" {
  name           = "python-test-apigw"
  protocol_type  = "HTTP"

  depends_on = [ aws_lambda_function.python-test-lambda ]
  
}

# Create integration
resource "aws_apigatewayv2_integration" "python-test-api-integration" {
  api_id             = aws_apigatewayv2_api.python-test-apigw.id
  integration_type   = "AWS_PROXY"

  integration_uri    = aws_lambda_function.python-test-lambda.invoke_arn

  depends_on = [ aws_apigatewayv2_api.python-test-apigw  ]
    
}

# Create route attached to integration
resource "aws_apigatewayv2_route" "python-test-route" {
  api_id             = aws_apigatewayv2_api.python-test-apigw.id
  route_key          = "ANY /"  
  target             = "integrations/${aws_apigatewayv2_integration.python-test-api-integration.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.python-test-api-auth0-jwt-auth.id

  depends_on = [ 
    aws_apigatewayv2_api.python-test-apigw, 
    aws_apigatewayv2_integration.python-test-api-integration, 
    aws_lambda_function.python-test-lambda, aws_apigatewayv2_authorizer.python-test-api-auth0-jwt-auth 
  ]
}

# Create stage
resource "aws_apigatewayv2_stage" "python-test-stage" {
  api_id      = aws_apigatewayv2_api.python-test-apigw.id
  name        = "test"
  auto_deploy = true

}

# Attach lambda trigger
resource "aws_lambda_permission" "python-test-apigw-trigger" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.python-test-lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.python-test-apigw.execution_arn}/*/*"
}