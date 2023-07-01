terraform { 
  required_version = "~> 1.0"    
  required_providers {
    aws = {
      version = "~> 3.0"
      source = "hashicorp/aws"
    }  
  }
}

provider "aws" {
    profile = "N.Virginia"
    region = "us-east-1"
    #default_tags {
      # tags = local.default_tags  # for this you will have a locals block where you defined your default_tags
   # }
}

terraform{ 
  backend "s3" {
    bucket = "class31demo1"
    key    = "terraform/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"
    encrypt = true
  }
}

module "Backends" {
    source = "./Backends"
  }

  module "Node1" {
    source = "./Node1"
  }