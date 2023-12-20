output "instance_ec2_id" {
  value = aws_instance.akey_instance.id
  description = "EC2 instance ID"
}
output "instance_ec2_host_id" {
  value = aws_instance.akey_instance.host_id
  description = "EC2 instance Host ID"
}

output "instance_public_ip" {
  value = aws_instance.akey_instance.public_ip
  description = "EC2 public IP"
}
