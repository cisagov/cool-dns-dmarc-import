# cool-dns-dmarc-import #

[![GitHub Build Status](https://github.com/cisagov/cool-dns-dmarc-import/workflows/build/badge.svg)](https://github.com/cisagov/cool-dns-dmarc-import/actions)

Terraform code to create the necessary resources to run the
dmarc-import application in the COOL DNS account.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |
| aws.dnsprovisionaccount | ~> 3.38 |
| aws.organizationsreadonly | ~> 3.38 |
| terraform | n/a |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| dmarc\_import | github.com/cisagov/dmarc-import-tf-module | n/a |

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_policy.elasticsearchreadonly_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.elasticsearchreadwrite_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.provisiondmarcimport](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.elasticsearchreadonly_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.elasticsearchreadwrite_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.elasticsearchreadonly_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.elasticsearchreadwrite_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.provisiondmarcimport](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.elasticsearchreadonly_assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.elasticsearchreadonly_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.elasticsearchreadwrite_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisiondmarcimport](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.cool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.dns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.master](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region to communicate with. | `string` | `"us-east-1"` | no |
| cyhy\_account\_id | The ID of the CyHy account. | `string` | n/a | yes |
| elasticsearch\_domain\_name | The domain name of the Elasticsearch instance. | `string` | `"dmarc-import-elasticsearch"` | no |
| elasticsearch\_index | The Elasticsearch index to which to write DMARC aggregate report data. | `string` | `"dmarc_aggregate_reports"` | no |
| elasticsearch\_type | The Elasticsearch type corresponding to a DMARC aggregate report. | `string` | `"report"` | no |
| elasticsearchreadonly\_role\_description | The description to associate with the IAM role (and policy) that allows sufficient permissions to read (but not write) to the dmarc-import Elasticsearch database. | `string` | `"Allows sufficient permissions to read (but not write) to the dmarc-import Elasticsearch database."` | no |
| elasticsearchreadonly\_role\_name | The name to assign the IAM role (and policy) that allows sufficient permissions to read (but not write) the to dmarc-import Elasticsearch database. | `string` | `"ElasticsearchReadOnly"` | no |
| elasticsearchreadwrite\_role\_description | The description to associate with the IAM role (and policy) that allows sufficient permissions to read and write to the dmarc-import Elasticsearch database. | `string` | `"Allows sufficient permissions to read and write to the dmarc-import Elasticsearch database."` | no |
| elasticsearchreadwrite\_role\_name | The name to assign the IAM role (and policy) that allows sufficient permissions to read and write the to dmarc-import Elasticsearch database. | `string` | `"ElasticsearchReadWrite"` | no |
| emails | A list of the email addresses at which DMARC aggregate reports are being received. | `list(string)` | ```[ "reports@dmarc.cyber.dhs.gov" ]``` | no |
| lambda\_function\_name | The name of the dmarc-import Lambda function. | `string` | `"dmarc-import"` | no |
| lambda\_function\_zip\_file | The location of the zip file for the Lambda function. | `string` | `"../dmarc-import-lambda/dmarc-import.zip"` | no |
| permanent\_bucket\_name | The name of the S3 bucket where the DMARC aggregate report emails are stored permanently. | `string` | `"cool-dmarc-import-permanent"` | no |
| provisiondmarcimport\_policy\_description | The description to associate with the IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure. | `string` | `"Allows sufficient permissions to provision the dmarc-import infrastructure."` | no |
| provisiondmarcimport\_policy\_name | The name to assign the IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure. | `string` | `"ProvisionDmarcImport"` | no |
| queue\_name | The name of the SQS queue where events will be sent as DMARC aggregate reports are received. | `string` | `"cool-dmarc-import-queue"` | no |
| rule\_set\_name | The name of the SES rule set that processes DMARC aggregate reports. | `string` | `"dmarc-import-rules"` | no |
| tags | Tags to apply to all AWS resources created | `map(string)` | ```{ "Application": "COOL - DNS - dmarc-import", "Team": "VM Fusion - Development", "Workspace": "production" }``` | no |
| temporary\_bucket\_name | The name of the S3 bucket where the DMARC aggregate report emails are stored temporarily (until processed). | `string` | `"cool-dmarc-import-temporary"` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| elasticsearchreadonly\_role | IAM role that allows sufficient permissions to read (but not write) to the dmarc-import Elasticsearch database. |
| elasticsearchreadwrite\_role | IAM role that allows sufficient permissions to read and write to the dmarc-import Elasticsearch database. |
| provisiondmarcimport\_policy | IAM policy that allows sufficient permissions to provision the dmarc-import infrastructure. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every
directory that contains Terraform code. In this repository, this is
only the main directory.

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
