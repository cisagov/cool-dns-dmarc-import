output "elasticsearchreadonly_role" {
  value       = aws_iam_role.elasticsearchreadonly_role
  description = "IAM role that allows sufficient permissions to read (but not write) to the dmarc-import Elasticsearch database."
}

output "elasticsearchreadwrite_role" {
  value       = aws_iam_role.elasticsearchreadwrite_role
  description = "IAM role that allows sufficient permissions to read and write to the dmarc-import Elasticsearch database."
}

output "provisiondmarcimport_policy" {
  value       = aws_iam_policy.provisiondmarcimport
  description = "IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure."
}
