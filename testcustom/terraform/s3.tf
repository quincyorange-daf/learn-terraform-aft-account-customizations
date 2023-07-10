data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "testcustom_bucket" {
  bucket = "aft-sandboxtestcustom-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
}
