terraform {
  backend "s3" {
    bucket = "vkt-terraform"
    region = "us-east-1"
    # Replace this with your path to store tf_state in s3
    key = "rancher/terraform.tfstate"
    skip_credentials_validation = true
  }
}
