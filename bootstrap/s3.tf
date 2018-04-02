/*
This terraform is used to create a remote state s3 bucket with the following details
- Name format, must be DNS compatible : check variables.tf
- Uses a private acl
- Has AES 256 server side encrytion
*/

provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "terraform-remote-state" {
  bucket = "${var.bucket-name}"

  acl = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags {
    Name = "S3 Remote Terraform State Store"
  }
}
