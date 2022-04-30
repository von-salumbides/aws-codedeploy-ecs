module "codedeploy_app" {
  source           = "git::https://github.com/von-salumbides/terraform-module.git//aws-codedeploy-app?ref=v0.1.2"
  env              = var.env
  project          = var.project
  compute_platform = "ECS"
}

