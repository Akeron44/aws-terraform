output "s3_website_endpoint" {
  description = "S3 Website Endpoint"
  value       = aws_s3_bucket.akeron_bucket.website_endpoint
}
output "s3_website_domain" {
  description = "S3 Website domain"
  value       = aws_s3_bucket.akeron_bucket.website_domain
}

output "s3_bucket_regional_domain_name" {
  description = "S3 Regional Domain Name"
  value       = aws_s3_bucket.akeron_bucket.bucket_regional_domain_name
}
