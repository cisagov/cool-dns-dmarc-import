# ------------------------------------------------------------------------------
# Create the IAM policy that allows read and write access to the
# dmarc-import Elasticsearch database in the DNS account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "elasticsearchreadwrite_doc" {
  statement {
    actions = [
      "es:ESHttp*",
    ]
    resources = [
      module.dmarc_import.elasticsearch_domain.arn,
      "${module.dmarc_import.elasticsearch_domain.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "elasticsearchreadwrite_policy" {
  provider = aws.dnsprovisionaccount

  description = var.elasticsearchreadwrite_role_description
  name        = var.elasticsearchreadwrite_role_name
  policy      = data.aws_iam_policy_document.elasticsearchreadwrite_doc.json
}
