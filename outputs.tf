output "create_lambda_policy" {
  value       = aws_iam_policy.create_lambda
  description = "IAM policy that allows sufficient permissions to create the dmarc-import Lambda function."
}
