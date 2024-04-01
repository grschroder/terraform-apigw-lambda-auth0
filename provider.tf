terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    auth0 = {
      source  = "auth0/auth0"
      version = ">= 1.0.0"
    }
  }
  backend "local" {
    path = ".terraform.tfstate"
  }
}

provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  default_tags {
    tags = {
      Environment = "Test",
      Terraform   = "true"
    }
  }
}

provider "auth0" {
  domain        = var.AUTH0_DOMAIN
  client_id     = var.AUTH0_CLIENT_ID
  client_secret = var.AUTH0_CLIENT_SECRET
}
