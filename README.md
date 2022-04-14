# ![AWS](aws-logo.png) Bucket File Sync

[![CI](https://github.com/figurate/terraform-null-bucket-file-sync/actions/workflows/main.yml/badge.svg)](https://github.com/figurate/terraform-null-bucket-file-sync/actions/workflows/main.yml)

Purpose: Sync local files with an S3-compatible public Cloud bucket.

Rationale: Provide utility functions for managing Bucket content.

## Requirements

| Name | Version |
|------|---------|
| null | >= 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| null | >= 2.1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acl | Set permissions of uploaded files | `string` | `""` | no |
| bucket\_fqdn | The domain name of the S3-compatible bucket for s3cmd operations | `string` | `""` | no |
| bucket\_name | The URL of the S3-compatible bucket to sync with | `any` | n/a | yes |
| content\_path | Root path of local website content | `string` | `"."` | no |
| delete | Remove files from the destination that don't exist in the source | `string` | `"false"` | no |
| endpoint\_url | The URL of the S3-compatible endpoint where the bucket is hosted | `string` | `""` | no |
| env\_config | Additional environment variables to apply to the file sync command | `map(string)` | `{}` | no |
| excludes | A list of exclude filters to apply | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| includes | A list of include filters to apply | `list(string)` | `[]` | no |

## Outputs

No output.

