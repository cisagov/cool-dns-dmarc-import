#-------------------------------------------------------------------------------
# Build and configure the dmarc-import infrastructure.
#-------------------------------------------------------------------------------

module "dmarc_import" {
  source = "github.com/cisagov/dmarc-import-tf-module"

  providers = {
    aws = aws.dnsprovisionaccount
  }

  aws_region                      = var.aws_region
  cognito_authenticated_role_name = var.cognito_authenticated_role_name
  cognito_identity_pool_name      = var.cognito_identity_pool_name
  cognito_user_pool_client_name   = var.cognito_user_pool_client_name
  cognito_user_pool_domain        = var.cognito_user_pool_domain
  cognito_user_pool_name          = var.cognito_user_pool_name
  cognito_usernames               = var.cognito_usernames
  elasticsearch_domain_name       = var.elasticsearch_domain_name
  elasticsearch_index             = var.elasticsearch_index
  elasticsearch_type              = var.elasticsearch_type
  emails                          = var.emails
  lambda_function_name            = var.lambda_function_name
  lambda_function_zip_file        = var.lambda_function_zip_file
  permanent_bucket_name           = var.permanent_bucket_name
  queue_name                      = var.queue_name
  rule_set_name                   = var.rule_set_name
  temporary_bucket_name           = var.temporary_bucket_name
}
