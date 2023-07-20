data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "sandbox_bucket" {
  bucket = "aft-sandbox-99${data.aws_caller_identity.current.account_id}"
  acl    = "private"
}
resource "aws_s3_bucket" "sandbox_bucket2" {
  bucket = "aft-itptes2-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
}
