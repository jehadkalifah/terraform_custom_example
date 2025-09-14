terraform {
  # Specify the required Terraform version
  required_version = "~> 1.11" 
  # Specify the required provider version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.2.0"
    }
  }

  # For Terraform Remote State File
  #   backend "s3" {
  #     bucket         = "s3-terraform-state-bucket"
  #     key            = "tfstate/terraform.tfstate"
  #     region         = "eu-west-1"
  #     # Enable state locking and consistency checking
  #     dynamodb_table = "terraform_remote_state_table"
  # }
}

provider "aws" {
    region  = "eu-west-1"
}