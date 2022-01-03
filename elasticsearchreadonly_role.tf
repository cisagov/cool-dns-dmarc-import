# ------------------------------------------------------------------------------
# Create the IAM role that allows read-only access to the dmarc-import
# Elasticsearch database in the DNS account.
# ------------------------------------------------------------------------------

# An IAM policy document that allows the users account and the CyHy
# account to assume the role.
data "aws_iam_policy_document" "elasticsearchreadonly_assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"
      identifiers = [
        local.users_account_id,
        var.cyhy_account_id,
      ]
    }
  }
}

resource "aws_iam_role" "elasticsearchreadonly_role" {
  provider = aws.dnsprovisionaccount

  assume_role_policy = data.aws_iam_policy_document.elasticsearchreadonly_assume_role_doc.json
  description        = var.elasticsearchreadonly_role_description
  name               = var.elasticsearchreadonly_role_name
}

resource "aws_iam_role_policy_attachment" "elasticsearchreadonly_policy_attachment" {
  provider = aws.dnsprovisionaccount

  policy_arn = aws_iam_policy.elasticsearchreadonly_policy.arn
  role       = aws_iam_role.elasticsearchreadonly_role.name
}
