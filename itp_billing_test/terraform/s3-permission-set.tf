module "permission_sets" {
    source = "../../modules/permission-sets"

  permission_sets = [
    {
      name               = "ITPAFTAdministratorAccess",
      description        = "Allow Full Access to the account",
      relay_state        = "",
      session_duration   = "",
      tags               = {},
      inline_policy      = "",
      policy_attachments = ["arn:aws:iam::aws:policy/ITPAFTAdministratorAccess"]
      customer_managed_policy_attachments = [{
        name = aws_iam_policy.ITPADTS3Access.name
        path = aws_iam_policy.ITPAFTS3Access.path
      }]
    },
    {
      name                                = "ITPAFTS3AdministratorAccess",
      description                         = "Allow Full S3 Admininstrator access to the account",
      relay_state                         = "",
      session_duration                    = "",
      tags                                = {},
      inline_policy                       = data.aws_iam_policy_document.ITPAFTS3Access.json,
      policy_attachments                  = []
      customer_managed_policy_attachments = []
    }
  ]
  context = module.this.context
}

module "sso_account_assignments" {
    source = "../../modules/permission-sets"

  account_assignments = [
    {
      account             = "192799173847", # Represents the "ipt-aft?-test" accounts
      permission_set_arn  = module.permission_sets.permission_sets["ITPAFTAdministratorAccess"].arn,
      permission_set_name = "ITPAFTAdministratorAccess",
      principal_type      = "GROUP",
      principal_name      = "ITPAFTAdministrators"
    },
    {
      account             = "620930051005",
      permission_set_arn  = module.permission_sets.permission_sets["ITPAFTS3AdministratorAccess"].arn,
      permission_set_name = "ITPAFTS3AdministratorAccess",
      principal_type      = "GROUP",
      principal_name      = "ITPAFTS3Adminstrators"
    },
     ]
  context = module.this.context
}

#-----------------------------------------------------------------------------------------------------------------------
# CREATE SOME IAM POLICIES TO ATTACH AS INLINE
#-----------------------------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "ITPAFTS3Access" {
  statement {
    sid = "1"

    actions = ["*"]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

#-----------------------------------------------------------------------------------------------------------------------
# CREATE SOME IAM POLICIES TO ATTACH AS MANAGED
#-----------------------------------------------------------------------------------------------------------------------
resource "aws_iam_policy" "ITPAFTS3Access" {
  name   = "ITPAFTS3Access"
  path   = "/"
  policy = data.aws_iam_policy_document.ITPAFTS3Access.json
  tags   = module.this.tags
}