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

  # This statement allows the deletion of scroll contexts.  These are
  # expensive resources, so there is an upper limit on the number of
  # them that can be open at once.  They should be deleted as soon as
  # possible after use, and their deletion does not actually delete
  # any data from the database.
  statement {
    actions = [
      "es:ESHttpDelete",
    ]
    resources = [
      "${module.dmarc_import.elasticsearch_domain.arn}/_search/scroll",
    ]
  }
}

resource "aws_iam_policy" "elasticsearchreadonly_policy" {
  provider = aws.dnsprovisionaccount

  description = var.elasticsearchreadonly_role_description
  name        = var.elasticsearchreadonly_role_name
  policy      = data.aws_iam_policy_document.elasticsearchreadonly_doc.json
}
