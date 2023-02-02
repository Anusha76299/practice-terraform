terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.50.0"
    }
    grafana = {
      source = "grafana/grafana"
    }
  }
  }
provider "aws" {
  region  = "us-east-1"
}
