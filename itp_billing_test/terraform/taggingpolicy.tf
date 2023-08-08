data "aws_iam_policy_document" "TechTeamTag" {
  statement {
    effect    = "Deny"  # Change the effect to "Deny" to block the action
    actions   = ["ec2:RunInstances"]  # Specify the action for EC2 instance creation
    resources = ["arn:aws:ec2:*:*:instance/*"]  # Block for all resources, you can narrow this down if needed
    condition {
      test     = "Null"  # Check if the tag exists and its value is not equal to the required value
      variable = "aws:RequestTag/technicalteam"
      values   = ["ISS, HC, SA"] # This is the required value for the "technicalteam" tag
    }
  }
}

resource "aws_organizations_policy" "TechTeamTag" {
  name    = "TechTeamTag"
  content = data.aws_iam_policy_document.TechTeamTag.json
}
# Attach the policy to the specific OU "test-aft"
resource "aws_organizations_policy_attachment" "TechTeamTag" {
  policy_id = aws_organizations_policy.TechTeamTag.id
  target_id = "ou-gggb-taoatbmf"  # Replace this with the actual ID of the "test-aft" OU
}