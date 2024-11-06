output "ec2_id" {
  description = "The id of the EC2"
  value       = aws_instance.ec2_example.id
}
