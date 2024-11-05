output "ec2_module" {
  description = "The outputs of the ec2 module"
  value       = module.ec2
}
output "vpc_module" {
  description = "The outputs of the vpc module"
  value       = module.vpc
}
output "lbmodule" {
  description = "The outputs of the lb module"
  value       = module.lb
}
