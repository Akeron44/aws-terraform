data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name        = "aws_iam_policy_for_terraform_aws_lambda_role_akeron"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy      = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
    "Effect": "Allow",
    "Action": "logs:CreateLogGroup",
    "Resource": "arn:aws:logs:eu-central-1:863872515231:*"
   },
   {
    "Effect": "Allow",
    "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
            ],
    "Resource": [
        "arn:aws:logs:eu-central-1:863872515231:log-group:/aws/lambda/akeronfunction:*"
    ]
  }
 ]
}
EOF
}


resource "aws_iam_role" "iam_for_lambda" {
  name               = "akeronLambdaRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "modules/lambda/index.mjs"
  output_path = "modules/lambda/nodejs.zip"
}


resource "aws_lambda_function" "test_lambda" {
  # filename      = data.archive_file.lambda.output_path
  filename      = "modules/lambda/nodejs.zip"
  function_name = "akeronfunction"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
  runtime       = "nodejs18.x"

  # source_code_hash = data.archive_file.lambda.output_base64sha256



}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.s3_bucket_id

  lambda_function {
    lambda_function_arn = aws_lambda_function.test_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_bucket, aws_iam_policy.iam_policy_for_lambda, aws_lambda_function.test_lambda]
}

resource "aws_cloudwatch_log_group" "yada" {
  name = "/aws/lambda/akeronfunction"
}
