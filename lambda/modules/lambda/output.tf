output "lambda_function_name" {
  description = "The name of the lambda function"
  value       = aws_lambda_function.test_lambda.function_name
}

# output "lambda_log" {
#   value = aws_iam_role_policy_attachment.logging_policy_attachment
# }
