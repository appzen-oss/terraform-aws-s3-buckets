output "arns" {
  description = "List of AWS S3 Bucket ARNs"
  value       = concat(aws_s3_bucket.this.*.arn, aws_s3_bucket.encrypted.*.arn)
}

output "domain_names" {
  description = "List of AWS S3 Bucket Domain Names"
  value = concat(
    aws_s3_bucket.this.*.bucket_domain_name,
    aws_s3_bucket.encrypted.*.bucket_domain_name,
  )
}

output "hosted_zone_ids" {
  description = "List of AWS S3 Bucket Hosted Zone IDs"
  value = concat(
    aws_s3_bucket.this.*.hosted_zone_id,
    aws_s3_bucket.encrypted.*.hosted_zone_id,
  )
}

output "ids" {
  description = "List of AWS S3 Bucket IDs"
  value       = concat(aws_s3_bucket.this.*.id, aws_s3_bucket.encrypted.*.id)
}

output "name_bases" {
  description = "List of base names used to generate S3 bucket names"
  value       = var.names
}

output "names" {
  description = "List of AWS S3 Bucket Names"
  value       = concat(aws_s3_bucket.this.*.id, aws_s3_bucket.encrypted.*.id)
}

output "regional_domain_names" {
  description = "List of AWS S3 region specific domain names"
  value = concat(
    aws_s3_bucket.this.*.bucket_regional_domain_name,
    aws_s3_bucket.encrypted.*.bucket_regional_domain_name,
  )
}

output "regions" {
  description = "List of AWS S3 Bucket Regions"
  value = concat(
    aws_s3_bucket.this.*.region,
    aws_s3_bucket.encrypted.*.region,
  )
}

#aws_s3_bucket_object.this.id
#aws_s3_bucket_object.this.etag
#aws_s3_bucket_object.this.version_id
