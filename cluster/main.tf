provider "aws" {
  region = "eu-central-1"
}

module "rds" {
  source = "./modules/rds"
}

module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source   = "./modules/ecs"
  db_name  = module.rds.db_name
  port     = module.rds.port
  db_host  = module.rds.db_host
  password = module.rds.password
  username = module.rds.username
}
