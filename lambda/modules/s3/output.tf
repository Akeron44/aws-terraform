output "s3_arn" {
  description = "The arn of the s3"
  value       = aws_s3_bucket.akeron_bucket.arn
}
output "s3_bucket_id" {
  description = "The id of the s3 bucket"
  value       = aws_s3_bucket.akeron_bucket.id
}
