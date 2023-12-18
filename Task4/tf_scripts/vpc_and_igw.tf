

locals {
  vpc_cidr = "10.10.0.0/16"
}

resource "aws_eip" "nat" {
  count = 1

  vpc = true
}

module "akey_demo_vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = "akey_demo_vpc"
  cidr                 = local.vpc_cidr
  azs                  = [data.aws_availability_zones.available.names.0]
  private_subnets      = [cidrsubnet(local.vpc_cidr, 8, 0)]
  public_subnets       = [cidrsubnet(local.vpc_cidr, 8, 100)]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}" 
  
}

# Create a security group allowing SSH
resource "aws_security_group" "akey_security_group" {
  #vpc_id = aws_vpc.akey_vpc.id
  vpc_id = module.akey_demo_vpc.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "akey_security_group"
  }
}


