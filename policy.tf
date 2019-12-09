
data "template_file" "cloudfront" {
  count = "${module.enabled.value ? length(var.names) : 0}"
  template = "${file("${path.module}/templates/s3-bucket-policy-cloudfront.json")}"

  vars {
    cloudfront_access_identity_iam_arn = "${var.cloudfront_access_identity_iam_arn}"
    s3_bucket_arn = "${element(aws_s3_bucket.this.*.arn, count.index)}"
  }
}

data "template_file" "cross_account" {
  count = "${module.enabled.value ? length(var.names) : 0}"
  template = "${file("${path.module}/templates/s3-bucket-policy-cross-account.json")}"

  vars {
    principals    = "${var.principals}"
    s3_bucket_arn = "${element(aws_s3_bucket.this.*.arn, count.index)}"
    write_objects = "${var.allow_cross_account_write}"
  }
}

# https://aws.amazon.com/blogs/security/how-to-prevent-uploads-of-unencrypted-objects-to-amazon-s3/
data "template_file" "encryption" {
  count = "${module.enabled.value ? length(var.names) : 0}"
  template = "${file("${path.module}/templates/s3-bucket-policy-encryption.json")}"

  vars {
    kms           = "${var.kms_master_key_arn != "" ? true : false}"
    s3_bucket_arn = "${element(aws_s3_bucket.this.*.arn, count.index)}"
  }
}

locals {
  policy_non_empty = "${
    var.cloudfront_access_identity_iam_arn != "" ||
    length(var.principals) > 0 ||
    (var.encryption || var.kms_master_key_arn != "")
    ? 1 : 0}"
}
resource "aws_s3_bucket_policy" "all" {
  depends_on = ["aws_s3_bucket.this", "aws_s3_bucket_public_access_block.this"]
  count = "${module.enabled.value && local.policy_non_empty ? length(var.names) : 0}"
  bucket = "${element(aws_s3_bucket.this.*.id, count.index)}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "${aws_s3_bucket.this.id}-Policy",
  "Statement": [
    ${join(",\n", compact(list(
      "${var.cloudfront_access_identity_iam_arn != "" ? element(data.template_file.cloudfront.*.rendered, count.index) : ""}",
      "${length(var.principals) > 0 ? element(data.template_file.cross_account.*.rendered, count.index) : ""}",
      "${var.encryption || var.kms_master_key_arn != "" ? element(data.template_file.encryption.*.rendered, count.index) : ""}"
    )))}
  ]
}
POLICY
}
