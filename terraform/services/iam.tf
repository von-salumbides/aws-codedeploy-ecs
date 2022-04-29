module "iam_role" {
  source  = "git::https://github.com/von-salumbides/terraform-module.git//aws-iam_role"
  project = var.project
  env     = var.env
  purpose = "ecs"
  config  = "trust_services"
}

module "iam-policy-codedeploy" {
  source      = "git::https://github.com/von-salumbides/terraform-module.git//aws-iam-policy"
  project     = var.project
  env         = var.env
  aws_service = "codedeploy"
  aws_account = var.aws_account
  aws_region  = var.region
  iam_role    = [module.iam_role.name]
}

module "iam-policy-full" {
  source      = "git::https://github.com/von-salumbides/terraform-module.git//aws-iam-policy"
  project     = var.project
  env         = var.env
  aws_service = "admin"
  aws_account = var.aws_account
  aws_region  = var.region
  iam_role    = [module.iam_role.name]
}