# ------------------------------------------------------------------------------
# Create the IAM policy that allows creation of the dmarc-import
# Lambda.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "create_lambda" {
  statement {
    actions = [
      "lambda:*",
    ]

    resources = [
      "arn:aws:lambda:${var.aws_region}:${local.dns_account_id}:function:${var.lambda_name}",
    ]
  }
}

resource "aws_iam_policy" "create_lambda" {
  provider = aws.dnsprovisionaccount

  description = var.create_lambda_policy_description
  name        = var.create_lambda_policy_name
  policy      = data.aws_iam_policy_document.create_lambda.json
}

resource "aws_iam_role_policy_attachment" "create_lambda" {
  provider = aws.dnsprovisionaccount

  role       = data.terraform_remote_state.dns.outputs.provisionaccount_role.name
  policy_arn = aws_iam_policy.create_lambda.arn
}
