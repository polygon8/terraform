terraform {
  required_version = "0.11.5"

  backend "s3" {
    encrypt        = true
    bucket         = "poly8on-tfstate"
    dynamodb_table = "lock-tfstate-polygon8betacontent"
    region         = "eu-west-2"
    key            = "united-terraform-states/polygon8betacontent/terraform.tfstate"
  }
}

provider "aws" {
  version = "~> 1.13"
  region = "eu-west-2"
}
