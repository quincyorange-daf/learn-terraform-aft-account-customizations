provider "aws" {
  region = "ap-southeast-2"
}
## Create a Security Policy to restrict EC2 type 
data "aws_iam_policy_document" "restrict_ec2_types" {
  statement {
    sid       = "RestrictEc2Types"
    effect    = "Deny"
    actions   = ["ec2:RunInstances"]
    resources = ["arn:aws:ec2:*:*:instance/*"]

    condition {
      test     = "StringNotEquals"
      variable = "ec2:InstanceType"

      values = [
        
        "t3.medium",
        "c1.medium"
      ]
    }
  }
}

resource "aws_organizations_policy" "restrict_ec2_types" {
  name        = "restrict_ec2_types"
  description = "Allow certain EC2 instance types only."
  content     = data.aws_iam_policy_document.restrict_ec2_types.json
}

 #### To attch policy on Organization Account ########
 resource "aws_organizations_policy_attachment" "test-scp-custom" {
   policy_id = aws_organizations_policy.restrict_ec2_types.id  ## (Required) The unique identifier (ID) of the policy that you want to attach to the target.
  target_id = "ou-gggb-0k7see5q"  ## (Required) The unique identifier (ID) organizational unit, you want to attach the policy to.
 }