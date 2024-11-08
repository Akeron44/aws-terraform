resource "aws_s3_bucket" "akeron_bucket" {
  bucket = "akeronbucket"

  tags = {
    Name        = "akeronBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.akeron_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "website_bucket_policy_document" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.akeron_bucket.arn}/*", ]
  }

}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.akeron_bucket.id
  policy = data.aws_iam_policy_document.website_bucket_policy_document.json
}
