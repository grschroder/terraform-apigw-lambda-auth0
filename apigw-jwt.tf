resource "aws_apigatewayv2_authorizer" "python-test-api-auth0-jwt-auth" {
  api_id            = aws_apigatewayv2_api.python-test-apigw.id
  authorizer_type   = "JWT"
  name              = "Auth0-JWT-Authentication"
  identity_sources  = ["$request.header.Authorization"]
  jwt_configuration {
    issuer   = "https://${var.AUTH0_DOMAIN}/"
    audience = ["${auth0_resource_server.python-test-api-auth.identifier}"]
  }
  
  depends_on = [ auth0_resource_server.python-test-api-auth, auth0_client.python-test-api-auth-m2m-app ]
}