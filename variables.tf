# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

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

variable "create_lambda_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows sufficient permissions to create the dmarc-import Lambda function."
  default     = "Allows sufficient permissions to create the dmarc-import Lambda function."
}

variable "create_lambda_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows sufficient permissions to create the dmarc-import Lambda function."
  default     = "CreateDmarcImportLambda"
}

variable "lambda_name" {
  type        = string
  description = "The name of the dmarc-import Lambda function."
  default     = "dmarc-import"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default = {
    Team        = "VM Fusion - Development"
    Application = "COOL - DNS - dmarc-import"
    Workspace   = "production"
  }
}
