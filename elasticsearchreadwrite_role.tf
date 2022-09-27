# ------------------------------------------------------------------------------
# Create the IAM role that allows read and write access to the
# dmarc-import Elasticsearch database in the DNS account.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "elasticsearchreadwrite_role" {
  provider = aws.dnsprovisionaccount

  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = var.elasticsearchreadwrite_role_description
  name               = var.elasticsearchreadwrite_role_name
}

resource "aws_iam_role_policy_attachment" "elasticsearchreadwrite_policy_attachment" {
  provider = aws.dnsprovisionaccount

  policy_arn = aws_iam_policy.elasticsearchreadwrite_policy.arn
  role       = aws_iam_role.elasticsearchreadwrite_role.name
}
