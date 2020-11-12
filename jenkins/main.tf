terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-2"
}

data "aws_vpc" "default" {
    default = true
}
data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}


data "aws_subnet" "default" {
  vpc_id     = data.aws_vpc.default.id
  availability_zone = "ap-northeast-2a"
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.15.0"
  # insert the 10 required variables here
  
  instance_count                    = 1
  ami                               = "ami-064ab8637cf33f1bb"
  associate_public_ip_address       = true
  instance_type                     = "t2.medium"
  #ipv6_address_count               = 
  #ipv6_addresses                   = 
  name                              = "jenkins"
  #private_ip                       = 
  #user_data                        =
  key_name                          = "kr"
  monitoring                        = true
  subnet_id                         = data.aws_subnet.default.id

  root_block_device = [{
      volume_size = 8
  }]
}