# cool-dns-dmarc-import #

[![GitHub Build Status](https://github.com/cisagov/cool-dns-dmarc-import/workflows/build/badge.svg)](https://github.com/cisagov/cool-dns-dmarc-import/actions)

Terraform code to create the necessary resources to run the
dmarc-import application in the COOL DNS account.

## Usage ##

1. Run the command `terraform init`.
1. Run the command `terraform apply`.

## Providers ##

| Name | Version |
|------|---------|
| aws | n/a |
| aws.dnsprovisionaccount | n/a |
| aws.organizationsreadonly | n/a |
| terraform | n/a |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws_region | The AWS region to communicate with. | `string` | `us-east-1` | no |
| elasticsearch_domain_name | The domain name of the Elasticsearch instance. | `string` | `dmarc-import-elasticsearch` | no |
| elasticsearch_index | The Elasticsearch index to which to write DMARC aggregate report data. | `string` | `dmarc_aggregate_reports` | no |
| elasticsearch_type | The Elasticsearch type corresponding to a DMARC aggregate report. | `string` | `report` | no |
| emails | A list of the email addresses at which DMARC aggregate reports are being received. | `list(string)` | `[reports@dmarc.cyber.dhs.gov]` | no |
| lambda_function_name | The name of the dmarc-import Lambda function. | `string` | `dmarc-import` | no |
| lambda_function_zip_file | The location of the zip file for the Lambda function. | `string` | `../dmarc-import-lambda/dmarc-import.zip` | no |
| permanent_bucket_name | The name of the S3 bucket where the DMARC aggregate report emails are stored permanently. | `string` | `cool-dmarc-import-permanent` | no |
| provisiondmarcimport_policy_description | The description to associate with the IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure. | `string` | `Allows sufficient permissions to provision the dmarc-import infrastructure.` | no |
| provisiondmarcimport_policy_name | The name to assign the IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure. | `string` | `ProvisionDmarcImport` | no |
| queue_name | The name of the SQS queue where events will be sent as DMARC aggregate reports are received. | `string` | `cool-dmarc-import-queue` | no |
| rule_set_name | The name of the SES rule set that processes DMARC aggregate reports. | `string` | `dmarc-import-rules` | no |
| tags | Tags to apply to all AWS resources created | `map(string)` | `{Application: COOL - DNS - dmarc-import, Team: VM Fusion - Development, Workspace: production}` | no |
| temporary_bucket_name | The name of the S3 bucket where the DMARC aggregate report emails are stored temporarily (until processed). | `string` | `cool-dmarc-import-temporary` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| provisiondmarcimport_policy | IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is only the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
