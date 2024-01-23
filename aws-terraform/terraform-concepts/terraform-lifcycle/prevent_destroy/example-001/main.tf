terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "new-key"
  vpc_security_group_ids = ["sg-02c1117725853987e"]
  subnet_id              = "subnet-0f0a743882dced945"
  root_block_device {
    volume_size = "10"
  }
  tags = {
    "Name"           = "bastion-host"
    "id"             = "2560"
    "owner"          = "s4arnold"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }

  lifecycle {
    prevent_destroy = true 
    ignore_changes  = [tags, root_block_device]
  }
}
