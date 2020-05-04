/*
 * Sync local files with an S3-compatible public Cloud bucket.
 */
data "archive_file" "content" {
  output_path = "content.zip"
  type        = "zip"
  source_dir  = var.content_path
  excludes    = [".terraform", "*.tfvars"]
}

resource "null_resource" "content_sync" {
  triggers = {
    content_path = sha256(var.content_path)
    includes     = sha256(join(",", var.includes))
    excludes     = sha256(join(",", var.excludes))
    delete_flag  = sha256(var.delete)
    content_hash = data.archive_file.content.output_sha
  }
  provisioner "local-exec" {
    environment = var.env_config
    command     = <<EOF
aws s3 sync \
    ${var.endpoint_url != "" ? format("--endpoint-url=%s", var.endpoint_url) : ""} \
    ${length(var.excludes) > 0 ? local.excludes_string : ""} \
    ${length(var.includes) > 0 ? local.includes_string : ""} \
    ${var.acl != "" ? format("--acl %s", var.acl) : ""} \
    ${var.delete == "true" ? "--delete" : ""} \
    ${var.content_path} s3://${var.bucket_name}
EOF
  }
  provisioner "local-exec" {
    environment = var.env_config
    command     = <<EOF
s3cmd setacl --acl-public --recursive \
    ${var.endpoint_url != "" ? format("--host=%s", var.endpoint_url) : ""} \
    ${var.bucket_fqdn != "" ? format("--host-bucket=%s", var.bucket_fqdn) : ""} \
    s3://${var.bucket_name}
EOF
  }
}
