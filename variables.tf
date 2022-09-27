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
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
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

variable "elasticsearch_type" {
  type        = string
  description = "The Elasticsearch type corresponding to a DMARC aggregate report."
  default     = "report"
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

variable "emails" {
  type        = list(string)
  description = "A list of the email addresses at which DMARC aggregate reports are being received."
  default = [
    "reports@dmarc.cyber.dhs.gov",
  ]
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
  default = {
    Team        = "VM Fusion - Development"
    Application = "COOL - DNS - dmarc-import"
    Workspace   = "production"
  }
}

variable "temporary_bucket_name" {
  type        = string
  description = "The name of the S3 bucket where the DMARC aggregate report emails are stored temporarily (until processed)."
  default     = "cool-dmarc-import-temporary"
}
