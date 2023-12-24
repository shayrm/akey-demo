
# Initialize AWS provider
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "aws" {
  region = var.region# Change this to your desired region
}


# Data settings

data "aws_ami" "ubuntu" {
  most_recent = true
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "role" {
  name               = "akey-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "policy" {
  name        = "akey-policy"
  description = "A akey demo test policy"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "akey_iam_profile" {
  name = "akey_demo_iam_profile"
  role = aws_iam_role.role.name
}

#resource "aws_key_pair" "ssh_key" {
#  key_name   = "akey_key"
#  public_key = file("~/.ssh/akey_rsa.pub")
#}

# Create an SSH key pair
#module "key_pair" {
#  source = "terraform-aws-modules/key-pair/aws"
#
#  key_name           = "akey-one"
#  create_private_key = true
#}

# Create an EC2 instance
resource "aws_instance" "akey_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.ssh_key
  subnet_id     = module.akey_demo_vpc.private_subnets[0]
  security_groups = [aws_security_group.akey_security_group.id]
  iam_instance_profile = aws_iam_instance_profile.akey_iam_profile.name
  associate_public_ip_address = true

  tags = {
    Name = "akey_instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              curl -o akeyless https://akeyless-cli.s3.us-east-2.amazonaws.com/cli/latest/production/cli-linux-amd64
              chmod +x akeyless
              EOF
}


#resource "aws_key_pair" "akey_key_pair" {
#  key_name   = "akey_key_pair"
#  public_key = file("./id_rsa.pub") # Change this to the path of your public key
#}
