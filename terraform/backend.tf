terraform {
  backend "s3" {
    bucket         = "terraform-state-abhay-us-east-1"
    key            = "dev/terraform.tfstate" # this will later change per env
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

