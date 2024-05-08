output "elasticsearchreadonly_role" {
  description = "IAM role that allows sufficient permissions to read (but not write) to the dmarc-import Elasticsearch database."
  value       = aws_iam_role.elasticsearchreadonly_role
}

output "elasticsearchreadwrite_role" {
  description = "IAM role that allows sufficient permissions to read and write to the dmarc-import Elasticsearch database."
  value       = aws_iam_role.elasticsearchreadwrite_role
}

output "provisiondmarcimport_policy" {
  description = "IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure."
  value       = aws_iam_policy.provisiondmarcimport
}
