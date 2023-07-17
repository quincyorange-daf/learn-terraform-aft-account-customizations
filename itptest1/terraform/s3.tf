data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "itptest4-bucket" {
  bucket = "aft-itptest4-bucket-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
}
