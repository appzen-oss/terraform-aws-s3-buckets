module "s3" {
  source                             = "../../"
  names                              = ["bucket"]
  environment                        = "dev"
  organization                       = "testingorg"
  cloudfront_access_identity_iam_arn = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity XSWJ834MSAS"
  principals                         = "123456789012,234567890123"
  allow_cross_account_write          = true
  encryption                         = true
}
