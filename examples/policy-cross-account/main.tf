module "s3" {
  source       = "../../"
  names        = ["bucket"]
  environment  = "dev"
  organization = "testingorg"
  principals = "123456789012,234567890123"
  allow_cross_account_write = true
}
