output "public_ec2_id" {
  description = "The id of ec2 in the public subnet"
  value       = aws_instance.ec2_example.id
}

output "private_ec2_id" {
  description = "The id of ec2 in the private subnet"
  value       = aws_instance.ec2_example_2.id
}

output "security_group_id" {
  description = "The if of the security group"
  value       = aws_security_group.sg_example.id
}
