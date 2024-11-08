provider "aws" {
  region = "eu-central-1"
}

module "s3" {
  source = "./modules/s3"
}

module "lambda" {
  source       = "./modules/lambda"
  s3_arn       = module.s3.s3_arn
  s3_bucket_id = module.s3.s3_bucket_id
}
