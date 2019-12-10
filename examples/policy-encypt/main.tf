module "s3" {
  source       = "../../"
  names        = ["bucket"]
  environment  = "dev"
  organization = "testingorg"
  encryption   = true

  #kms_master_key_arn = "arn:aws:kms:us-east-1:123456789012:key/111-111-111-111-111"
}
