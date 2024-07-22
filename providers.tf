terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.36.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}
provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "random" {
}
provider "local" {
}