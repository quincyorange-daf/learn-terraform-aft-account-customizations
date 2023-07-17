data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "itptest4_bucket" {
  bucket = "aft-itptest4_bucket-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
}
