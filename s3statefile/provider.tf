provider "aws" {
  region = "us-east-1"

}

terraform {
  backend "s3" {
    bucket = "ansible-bucket-devops"
    key    = "myterraforstatefile"
    region = "us-east-1"
  }
}
