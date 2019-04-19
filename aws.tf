provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = ""
  profile                 = ""
}

terraform {
  backend "s3" {
    bucket = "gene-repository"
    key    = "./terraform/terraform.tfstate"
    region = "us-east-1"
  }
}