 #### To attch policy on Organization Account ########
 resource "aws_organizations_policy_attachment" "aft-test-cloudwatch-deny" {
   policy_id = aws_organizations_policy.aft-test-cloudwatch-deny.id  ## (Required) The unique identifier (ID) of the policy that you want to attach to the target.
  target_id = "ou-gggb-0k7see5q"  ## (Required) The unique identifier (ID) organizational unit, you want to attach the policy to.
 }