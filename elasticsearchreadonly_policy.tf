# ------------------------------------------------------------------------------
# Create the IAM policy that allows read-only access to the
# dmarc-import Elasticsearch database in the DNS account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "elasticsearchreadonly_doc" {
  statement {
    actions = [
      "es:ESHttpGet",
    ]
    resources = [
      module.dmarc_import.elasticsearch_domain.arn,
      "${module.dmarc_import.elasticsearch_domain.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "elasticsearchreadonly_policy" {
  provider = aws.dnsprovisionaccount

  description = var.elasticsearchreadonly_role_description
  name        = var.elasticsearchreadonly_role_name
  policy      = data.aws_iam_policy_document.elasticsearchreadonly_doc.json
}
