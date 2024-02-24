data "aws_caller_identity" "me" {}

data "aws_iam_policy_document" "LaunchWizardKMS" {
  statement {
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = [
      "arn:aws:kms:eu-central-1:${data.aws_caller_identity.me.account_id}:alias/aws/ebs"
    ]
  }
}

resource "aws_iam_policy" "LaunchWizardKMS" {
  name        = "LaunchWizardKMS"
  description = "Policy to allow Launch Wizard to use the EBS default KMS key"
  policy      = data.aws_iam_policy_document.LaunchWizardKMS.json
}

resource "aws_iam_role_policy_attachment" "LaunchWizardKMS" {
  policy_arn = aws_iam_policy.LaunchWizardKMS.arn
  role       = "AmazonEC2RoleForLaunchWizard"
}
