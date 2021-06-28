data "aws_kms_alias" "account" {
  name = "alias/account"
}

module "s3" {
  source             = "../../"
  names              = ["bucket"]
  environment        = "dev"
  organization       = "testingorg"
  encryption         = true
  kms_master_key_arn = data.aws_kms_alias.account.target_key_arn
}

output "kms_key_arn" {
  value = data.aws_kms_alias.account.arn
}

