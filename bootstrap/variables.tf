variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "eu-west-2"
}

variable "bucket-name" {
  description = "Name of bucket"
  default     = "poly8on-tfstate"
}
