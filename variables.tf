# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "cyhy_account_id" {
  type        = string
  description = "The ID of the CyHy account."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region to communicate with."
  default     = "us-east-1"
}

variable "cognito_authenticated_role_name" {
  default     = "dmarc-import-authenticated"
  description = "The name of the IAM role that grants authenticated access to the Elasticsearch database."
  type        = string
}

variable "cognito_identity_pool_name" {
  default     = "dmarc-import"
  description = "The name of the Cognito identity pool to use for access to the Elasticsearch database."
  type        = string
}

variable "cognito_user_pool_client_name" {
  default     = "dmarc-import"
  description = "The name of the Cognito user pool client to use for access to the Elasticsearch database."
  type        = string
}

variable "cognito_user_pool_domain" {
  default     = "dmarc-import"
  description = "The domain to use for the Cognito endpoint. For custom domains, this is the fully-qualified domain name, such as \"auth.example.com\". For Amazon Cognito prefix domains, this is the prefix alone, such as \"auth\"."
  type        = string
}

variable "cognito_user_pool_name" {
  default     = "dmarc-import"
  description = "The name of the Cognito user pool to use for access to the Elasticsearch database."
  type        = string
}

variable "cognito_usernames" {
  default     = {}
  description = "A map whose keys are the usernames of each Cognito user and whose values are a map containing supported user attributes.  The only currently-supported attribute is \"email\" (string).  Example: { \"firstname1.lastname1\" = { \"email\" = \"firstname1.lastname1@foo.gov\" }, \"firstname2.lastname2\" = { \"email\" = \"firstname2.lastname2@foo.gov\" } }"
  type        = map(object({ email = string }))
}

variable "elasticsearch_domain_name" {
  type        = string
  description = "The domain name of the Elasticsearch instance."
  default     = "dmarc-import-elasticsearch"
}

variable "elasticsearch_index" {
  type        = string
  description = "The Elasticsearch index to which to write DMARC aggregate report data."
  default     = "dmarc_aggregate_reports"
}

variable "elasticsearchreadonly_role_description" {
  type        = string
  description = "The description to associate with the IAM role (and policy) that allows sufficient permissions to read (but not write) to the dmarc-import Elasticsearch database."
  default     = "Allows sufficient permissions to read (but not write) to the dmarc-import Elasticsearch database."
}

variable "elasticsearchreadonly_role_name" {
  type        = string
  description = "The name to assign the IAM role (and policy) that allows sufficient permissions to read (but not write) the to dmarc-import Elasticsearch database."
  default     = "ElasticsearchReadOnly"
}

variable "elasticsearchreadwrite_role_description" {
  type        = string
  description = "The description to associate with the IAM role (and policy) that allows sufficient permissions to read and write to the dmarc-import Elasticsearch database."
  default     = "Allows sufficient permissions to read and write to the dmarc-import Elasticsearch database."
}

variable "elasticsearchreadwrite_role_name" {
  type        = string
  description = "The name to assign the IAM role (and policy) that allows sufficient permissions to read and write the to dmarc-import Elasticsearch database."
  default     = "ElasticsearchReadWrite"
}

variable "elasticsearch_type" {
  type        = string
  description = "The Elasticsearch type corresponding to a DMARC aggregate report."
  default     = "report"
}

variable "emails" {
  type        = list(string)
  description = "A list of the email addresses at which DMARC aggregate reports are being received."
  default = [
    "reports@dmarc.cyber.dhs.gov",
  ]
}

variable "opensearch_service_role_for_auth_name" {
  default     = "opensearch-service-cognito-access"
  description = "The name of the IAM role that gives Amazon OpenSearch Service permissions to configure the Amazon Cognito user and identity pools and use them for OpenSearch Dashboards/Kibana authentication."
  type        = string
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the dmarc-import Lambda function."
  default     = "dmarc-import"
}

variable "lambda_function_zip_file" {
  type        = string
  description = "The location of the zip file for the Lambda function."
  default     = "../dmarc-import-lambda/dmarc-import.zip"
}

variable "permanent_bucket_name" {
  type        = string
  description = "The name of the S3 bucket where the DMARC aggregate report emails are stored permanently."
  default     = "cool-dmarc-import-permanent"
}

variable "provisiondmarcimport_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure."
  default     = "Allows sufficient permissions to provision the dmarc-import infrastructure."
}

variable "provisiondmarcimport_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure."
  default     = "ProvisionDmarcImport"
}

variable "queue_name" {
  type        = string
  description = "The name of the SQS queue where events will be sent as DMARC aggregate reports are received."
  default     = "cool-dmarc-import-queue"
}

variable "rule_set_name" {
  type        = string
  description = "The name of the SES rule set that processes DMARC aggregate reports."
  default     = "dmarc-import-rules"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}

variable "temporary_bucket_name" {
  type        = string
  description = "The name of the S3 bucket where the DMARC aggregate report emails are stored temporarily (until processed)."
  default     = "cool-dmarc-import-temporary"
}
