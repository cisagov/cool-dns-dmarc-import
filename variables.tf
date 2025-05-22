# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "cyhy_account_id" {
  description = "The ID of the CyHy account."
  nullable    = false
  type        = string
}

variable "terraform_state_bucket" {
  description = "The name of the S3 bucket where Terraform state is stored."
  nullable    = false
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region to deploy into (e.g. us-east-1)."
  nullable    = false
  type        = string
}

variable "cognito_authenticated_role_name" {
  default     = "dmarc-import-authenticated"
  description = "The name of the IAM role that grants authenticated access to the Elasticsearch database."
  nullable    = false
  type        = string
}

variable "cognito_identity_pool_name" {
  default     = "dmarc-import"
  description = "The name of the Cognito identity pool to use for access to the Elasticsearch database."
  nullable    = false
  type        = string
}

variable "cognito_user_pool_client_name" {
  default     = "dmarc-import"
  description = "The name of the Cognito user pool client to use for access to the Elasticsearch database."
  nullable    = false
  type        = string
}

variable "cognito_user_pool_domain" {
  default     = "dmarc-import"
  description = "The domain to use for the Cognito endpoint. For custom domains, this is the fully-qualified domain name, such as \"auth.example.com\". For Amazon Cognito prefix domains, this is the prefix alone, such as \"auth\"."
  nullable    = false
  type        = string
}

variable "cognito_user_pool_name" {
  default     = "dmarc-import"
  description = "The name of the Cognito user pool to use for access to the Elasticsearch database."
  nullable    = false
  type        = string
}

variable "cognito_usernames" {
  default     = {}
  description = "A map whose keys are the usernames of each Cognito user and whose values are a map containing supported user attributes.  The only currently-supported attribute is \"email\" (string).  Example: `{ \"firstname1.lastname1\" = { \"email\" = \"firstname1.lastname1@foo.gov\" }, \"firstname2.lastname2\" = { \"email\" = \"firstname2.lastname2@foo.gov\" } }`"
  nullable    = false
  type        = map(object({ email = string }))
}

variable "elasticsearch_domain_name" {
  default     = "dmarc-import-elasticsearch"
  description = "The domain name of the Elasticsearch instance."
  nullable    = false
  type        = string
}

variable "elasticsearch_index" {
  default     = "dmarc_aggregate_reports"
  description = "The Elasticsearch index to which to write DMARC aggregate report data."
  nullable    = false
  type        = string
}

variable "elasticsearchreadonly_role_description" {
  default     = "Allows sufficient permissions to read (but not write) to the dmarc-import Elasticsearch database."
  description = "The description to associate with the IAM role (and policy) that allows sufficient permissions to read (but not write) to the dmarc-import Elasticsearch database."
  nullable    = false
  type        = string
}

variable "elasticsearchreadonly_role_name" {
  default     = "ElasticsearchReadOnly"
  description = "The name to assign the IAM role (and policy) that allows sufficient permissions to read (but not write) the to dmarc-import Elasticsearch database."
  nullable    = false
  type        = string
}

variable "elasticsearchreadwrite_role_description" {
  default     = "Allows sufficient permissions to read and write to the dmarc-import Elasticsearch database."
  description = "The description to associate with the IAM role (and policy) that allows sufficient permissions to read and write to the dmarc-import Elasticsearch database."
  nullable    = false
  type        = string
}

variable "elasticsearchreadwrite_role_name" {
  default     = "ElasticsearchReadWrite"
  description = "The name to assign the IAM role (and policy) that allows sufficient permissions to read and write the to dmarc-import Elasticsearch database."
  nullable    = false
  type        = string
}

variable "elasticsearch_type" {
  default     = "report"
  description = "The Elasticsearch type corresponding to a DMARC aggregate report."
  nullable    = false
  type        = string
}

variable "emails" {
  default     = ["reports@dmarc.cyber.dhs.gov", ]
  description = "A list of the email addresses at which DMARC aggregate reports are being received."
  nullable    = false
  type        = list(string)
}

variable "opensearch_service_role_for_auth_name" {
  default     = "opensearch-service-cognito-access"
  description = "The name of the IAM role that gives Amazon OpenSearch Service permissions to configure the Amazon Cognito user and identity pools and use them for OpenSearch Dashboards/Kibana authentication."
  nullable    = false
  type        = string
}

variable "lambda_function_name" {
  default     = "dmarc-import"
  description = "The name of the dmarc-import Lambda function."
  nullable    = false
  type        = string
}

variable "lambda_function_zip_file" {
  default     = "../dmarc-import-lambda/dmarc-import.zip"
  description = "The location of the zip file for the Lambda function."
  nullable    = false
  type        = string
}

variable "permanent_bucket_name" {
  default     = "cool-dmarc-import-permanent"
  description = "The name of the S3 bucket where the DMARC aggregate report emails are stored permanently."
  nullable    = false
  type        = string
}

variable "provisiondmarcimport_policy_description" {
  default     = "Allows sufficient permissions to provision the dmarc-import infrastructure."
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure."
  nullable    = false
  type        = string
}

variable "provisiondmarcimport_policy_name" {
  default     = "ProvisionDmarcImport"
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure."
  nullable    = false
  type        = string
}

variable "queue_name" {
  default     = "cool-dmarc-import-queue"
  description = "The name of the SQS queue where events will be sent as DMARC aggregate reports are received."
  nullable    = false
  type        = string
}

variable "rule_set_name" {
  default     = "dmarc-import-rules"
  description = "The name of the SES rule set that processes DMARC aggregate reports."
  nullable    = false
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  nullable    = false
  type        = map(string)
}

variable "temporary_bucket_name" {
  default     = "cool-dmarc-import-temporary"
  description = "The name of the S3 bucket where the DMARC aggregate report emails are stored temporarily (until processed)."
  nullable    = false
  type        = string
}
