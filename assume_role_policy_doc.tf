# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the users and CyHy
# accounts to assume this role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    principals {
      identifiers = [
        local.users_account_id,
        var.cyhy_account_id,
      ]
      type = "AWS"
    }
  }
}
