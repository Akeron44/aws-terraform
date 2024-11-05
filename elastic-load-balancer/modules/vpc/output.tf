output "public_subnet_id" {
  description = "Id of the public subnet"
  value       = aws_subnet.public_subnet_example.id
}

output "private_subnet_id" {
  description = "Id of the private subnet"
  value       = aws_subnet.private_subnet_example.id
}

output "vpc_id" {
  description = "Id of the cpv"
  value       = aws_vpc.vpc_example.id
}
