module "s3" {
  source       = "../../"
  names        = ["bucket"]
  environment  = "dev"
  organization = "testingorg"
}
