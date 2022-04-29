module "codedeploy_app" {
  source           = "git::https://github.com/von-salumbides/terraform-module.git//aws-codedeploy-app"
  env              = var.env
  project          = var.project
  compute_platform = "ECS"
}

