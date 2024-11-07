output "public_subnet_id" {
  description = "The id of the public subnet"
  value       = aws_subnet.akeron_public_subnet.id
}
output "private_subnet_id" {
  description = "The id of the private subnet"
  value       = aws_subnet.akeron_private_subnet.id
}

output "vpc_id" {
  description = "The id of the vpc"
  value       = aws_vpc.akeron_vpc.id
}
