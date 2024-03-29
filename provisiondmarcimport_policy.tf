# ------------------------------------------------------------------------------
# Create the IAM policy that allows provisioning of the dmarc-import
# infrastructure.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisiondmarcimport" {
  # Permissions necessary to create and manipulate Cognito resources
  statement {
    actions = [
      "cognito-identity:CreateIdentityPool",
      "cognito-identity:DeleteIdentityPool",
      "cognito-identity:DescribeIdentityPool",
      "cognito-identity:GetIdentityPoolRoles",
      "cognito-identity:ListIdentityPools",
      "cognito-identity:SetIdentityPoolRoles",
      "cognito-identity:TagResource",
      "cognito-identity:UntagResource",
      "cognito-identity:UpdateIdentityPool",
      "cognito-idp:AddCustomAttributes",
      "cognito-idp:AdminCreateUser",
      "cognito-idp:AdminDeleteUser",
      "cognito-idp:AdminGetUser",
      "cognito-idp:AdminUpdateUserAttributes",
      "cognito-idp:CreateUserPool",
      "cognito-idp:CreateUserPoolClient",
      "cognito-idp:CreateUserPoolDomain",
      "cognito-idp:DeleteUserPool",
      "cognito-idp:DeleteUserPoolClient",
      "cognito-idp:DeleteUserPoolDomain",
      "cognito-idp:DescribeUserPool",
      "cognito-idp:DescribeUserPoolClient",
      "cognito-idp:DescribeUserPoolDomain",
      "cognito-idp:GetUserPoolMfaConfig",
      "cognito-idp:ListUserPoolClients",
      "cognito-idp:ListUserPools",
      "cognito-idp:SetUserPoolMfaConfig",
      "cognito-idp:TagResource",
      "cognito-idp:UntagResource",
      "cognito-idp:UpdateUserPool",
      "cognito-idp:UpdateUserPoolClient",
      "cognito-idp:UpdateUserPoolDomain",
    ]

    resources = [
      "*"
    ]
  }

  # Permissions necessary to create and manipulate the Lambda function
  statement {
    actions = [
      "lambda:*",
    ]

    resources = [
      "arn:aws:lambda:${var.aws_region}:${local.dns_account_id}:function:${var.lambda_function_name}",
    ]
  }

  # Permissions necessary to create and manipulate the temporary and
  # permanent buckets
  statement {
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${var.permanent_bucket_name}",
      "arn:aws:s3:::${var.temporary_bucket_name}",
    ]
  }

  # Permissions necessary to create and manipulate the queues
  statement {
    actions = [
      "sqs:*",
    ]
    resources = [
      "arn:aws:sqs:${var.aws_region}:${local.dns_account_id}:${var.queue_name}",
      "arn:aws:sqs:${var.aws_region}:${local.dns_account_id}:${var.queue_name}_dead_letter",
    ]
  }

  # Permissions necessary to create and manipulate the elasticsearch
  # domain
  statement {
    actions = [
      "es:*",
    ]
    resources = [
      "arn:aws:es:${var.aws_region}:${local.dns_account_id}:domain/${var.elasticsearch_domain_name}",
    ]
  }
  statement {
    actions = [
      # This permission should apply from the previous block, but for
      # some reason it doesn't.  The resource does not appear to be
      # incorrect, but for some reason I can't apply tags unless I add
      # it here.
      "es:AddTags",
      "es:CreateElasticsearchServiceRole",
      "es:DeleteElasticsearchServiceRole",
      "es:Describe*",
      "es:List*"
    ]
    resources = [
      "*",
    ]
  }

  # Permissions necessary to create and manipulate the SES rule set.
  # The SES actions only take wildcard resources, so we should only
  # list the actions that we actually need.
  statement {
    actions = [
      "ses:CreateReceiptRule",
      "ses:CreateReceiptRuleSet",
      "ses:DeleteReceiptRule",
      "ses:DeleteReceiptRuleSet",
      "ses:Describe*",
      "ses:List*",
      "ses:SetActiveReceiptRuleSet",
      "ses:UpdateReceiptRule",
    ]
    resources = [
      "*"
    ]
  }

  # Permissions necessary to create and manipulate the CloudWatch log
  # groups.  Here I use specific resource ARNs where possible.
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:DescribeLogGroups",
      "logs:DescribeResourcePolicies",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    actions = [
      "logs:DeleteLogGroup",
      "logs:DeleteResourcePolicy",
      "logs:DeleteRetentionPolicy",
      "logs:ListTagsLogGroup",
      "logs:PutResourcePolicy",
      "logs:PutRetentionPolicy",
      "logs:TagLogGroup",
      "logs:UntagLogGroup",
    ]
    resources = [
      "arn:aws:logs:${var.aws_region}:${local.dns_account_id}:log-group:/aws/aes/domains/${var.elasticsearch_domain_name}/application-logs",
      "arn:aws:logs:${var.aws_region}:${local.dns_account_id}:log-group:/aws/aes/domains/${var.elasticsearch_domain_name}/application-logs:*",
      "arn:aws:logs:${var.aws_region}:${local.dns_account_id}:log-group:/aws/lambda/${var.lambda_function_name}",
      "arn:aws:logs:${var.aws_region}:${local.dns_account_id}:log-group:/aws/lambda/${var.lambda_function_name}:*",
    ]
  }

  # Permissions necessary to create and manipulate the CloudWatch
  # event rule that regularly kicks off the Lambda
  statement {
    actions = [
      "events:*",
    ]
    resources = [
      "arn:aws:events:${var.aws_region}:${local.dns_account_id}:rule/ImportDmarcAggregateReports",
    ]
  }
}

resource "aws_iam_policy" "provisiondmarcimport" {
  provider = aws.dnsprovisionaccount

  description = var.provisiondmarcimport_policy_description
  name        = var.provisiondmarcimport_policy_name
  policy      = data.aws_iam_policy_document.provisiondmarcimport.json
}

resource "aws_iam_role_policy_attachment" "provisiondmarcimport" {
  provider = aws.dnsprovisionaccount

  policy_arn = aws_iam_policy.provisiondmarcimport.arn
  role       = data.terraform_remote_state.dns.outputs.provisionaccount_role.name
}
