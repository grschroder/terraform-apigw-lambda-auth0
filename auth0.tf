# Create an API resource
resource "auth0_resource_server" "python-test-api-auth" {
  name        = "Python test API auth (Managed by Terraform)"
  identifier  = "${aws_apigatewayv2_stage.python-test-stage.invoke_url}"
  signing_alg = "RS256"

  allow_offline_access                            = true
  token_lifetime                                  = 8600
  skip_consent_for_verifiable_first_party_clients = true

  depends_on = [ aws_apigatewayv2_stage.python-test-stage ]

}

# Create an API scope
resource "auth0_resource_server_scopes" "python-test-api-auth-read-all-scope" {
  resource_server_identifier = auth0_resource_server.python-test-api-auth.identifier

  scopes {
    name        = "read:all"
    description = "Ability to read all"
  }
}

# Attach the scope to API
resource "auth0_resource_server_scope" "python-test-api-auth-read-all-attach-scope" {
  resource_server_identifier = auth0_resource_server.python-test-api-auth.identifier
  scope                      = "read:all"
}

# Create a m2m app
resource "auth0_client" "python-test-api-auth-m2m-app" {
  name     = "Python test API auth M2M app (Managed by Terraform)"
  app_type = "non_interactive" 
}

# Grant m2m app access to the resource server
resource "auth0_client_grant" "python-test-api-auth-m2m-app-access" {
  client_id = auth0_client.python-test-api-auth-m2m-app.client_id
  audience  = auth0_resource_server.python-test-api-auth.identifier
  scopes    = ["read:all"]
}