data "terraform_remote_state" "remote" {
  backend "s3" {
    bucket         = "THE_NAME_OF_THE_STATE_BUCKET"
    key            = "some_environment/terraform.tfstate"  # path to your state file
    region         = "us-east-1"
    encrypt        = true        # may not be necccessary
    kms_key_id     = "THE_ID_OF_THE_KMS_KEY"  # may not be neccessary
    dynamodb_table = "THE_ID_OF_THE_DYNAMODB_TABLE"
  }
}
         
# OR

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "my-bucket-name"
    key = "my-key-name"
    region = "my-region"
  }
}     
          # then the resource you want to create (lets say we want to create an ec2 instance for this example)

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.key_pem
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnets[1] # we want to get this subnet_id from our remote state file 
                                                        # (which is already used to create # to create a vpc/network) and we pass the index [1] cause we have more than one private_subnets
                                                        # And these private_subnets must have already been passed as on output when creating our vpc
  
  tags = {
    Name = "node"
  }
}
