terraform {
  backend "s3" {
    bucket = "iaac-bucket1"
    key    = "s3/s3.tf"
    region = "us-east-1"
  } 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.46.0"
    }
  }
}
/*provider "aws" {
  region = local.origin_region
}

provider "aws" {
  region = local.replica_region
  alias  = "replica"
}

locals {
  #bucket_name = "iaac-translation-digital-enrollments-production"
  #destination_bucket_name = "myreplica-s3"
  origin_region  = "us-east-1"
  replica_region = "us-west-1" # replica
}*/