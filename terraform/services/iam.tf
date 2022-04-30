module "iam_role_tasks" {
  source  = "git::https://github.com/von-salumbides/terraform-module.git//aws-iam-role"
  project = var.project
  env     = var.env
  purpose = "ecs-task"
  config  = "ecs-task"
}

module "iam_role_exec" {
  source  = "git::https://github.com/von-salumbides/terraform-module.git//aws-iam-role"
  project = var.project
  env     = var.env
  purpose = "ecs-exec"
  config  = "ecs-exec"
}

module "iam_role_codedeploy" {
  source  = "git::https://github.com/von-salumbides/terraform-module.git//aws-iam-role"
  project = var.project
  env     = var.env
  purpose = "codedeploy"
  config  = "codedeploy"
}

module "iam-policy-codedeploy" {
  source      = "git::https://github.com/von-salumbides/terraform-module.git//aws-iam-policy"
  project     = var.project
  env         = var.env
  aws_service = "codedeploy"
  aws_account = var.aws_account
  aws_region  = var.region
  iam_role    = [module.iam_role_codedeploy.name,module.iam_role_tasks.name,module.iam_role_exec.name]
}