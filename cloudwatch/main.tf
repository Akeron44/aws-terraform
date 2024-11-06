provider "aws" {
  region = "eu-central-1"
}

module "ec2" {
  source = "./modules/ec2"
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  ec2_id = module.ec2.ec2_id
}
