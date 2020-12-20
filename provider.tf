provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "/Users/etcheby/.aws/credentials.txt"
  profile                 = "Terraform"
  version                 = "3.22"
}
