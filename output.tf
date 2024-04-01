#output "apigw_url" {
#    value = aws_api_gateway_deployment.api.url
#}

output "lambda_invoke_url" {
    value = aws_lambda_function_url.python-test-lambda-url.function_url

}

output "api_gateway_url" {
    value = aws_apigatewayv2_api.python-test-apigw.api_endpoint
}

output "api_gateway_stage_url" {
    value = aws_apigatewayv2_stage.python-test-stage.invoke_url
}

output "auth0_api_audience" {
    value = auth0_resource_server.python-test-api-auth.identifier
}

output "auth0_issuer_url" {
    value = "https://${var.AUTH0_DOMAIN}/"
}