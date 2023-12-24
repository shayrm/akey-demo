variable "region" {
  type = string
  default = "us-west-1"
}

variable "environment" {
  type = string
  default = "akey-demo"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "ssh_key" {
  type = string
  default = "akey_demo"
  
}
