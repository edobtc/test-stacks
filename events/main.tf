terraform {
  required_version = ">= 1.5.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.10.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
