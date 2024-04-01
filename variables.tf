variable "AWS_REGION" {
  description = "The AWS region"
  default     = "us-east-1"
}

variable "AWS_ACCESS_KEY" {
  description = "The AWS access"
  default     = "access-key"
}

variable "AWS_SECRET_KEY" {
  description = "The AWS secret key"
  default     = "key"
}

variable "AUTH0_DOMAIN" {
  description = "The Auth0 domain"
  default     = "domain"  
}

variable "AUTH0_CLIENT_ID" {
  description = "The Auth0 client id"
  default     = "client-id"
}

variable "AUTH0_CLIENT_SECRET" {
  description = "The Auth0 client secret"
  default     = "client-secret"
}