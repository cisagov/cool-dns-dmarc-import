output "provisiondmarcimport_policy" {
  value       = aws_iam_policy.provisiondmarcimport
  description = "IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure."
}
