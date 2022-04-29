//SECURITY GROUP(S)
module "security_group_ecs" {
  source  = "git::https://github.com/von-salumbides/terraform-module.git//aws-security-group?ref=v0.1.1"
  config  = "ECS"
  vpc     = var.vpc
  env     = var.env
  project = var.project
  source_id_var = {
    ALB = module.security-group-alb.id
  }
}

//SECURITY GROUP(S)
module "security-group-alb" {
  source        = "git::https://github.com/von-salumbides/terraform-module.git//aws-security-group?ref=v0.1.1"
  config        = "ALB"
  vpc           = var.vpc
  env           = var.env
  project       = var.project
  source_id_var = {}
}

module "lb" {
  source                     = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-app"
  project                    = var.project
  env                        = var.env
  security_group             = module.security-group-alb.id
  subnet_list                = var.subnet_list
  region                     = var.region
  aws_account                = var.aws_account
  purpose                    = "ext"
  internal                   = false
  is_https_enabled           = false
  enable_deletion_protection = false
}

module "target_group_blue" {
  source    = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-target-group"
  project   = var.project
  env       = var.env
  vpc       = var.vpc
  purpose   = "blue"
  tg_config = "TG-BLUE"
}

module "target_group_green" {
  source    = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-target-group"
  project   = var.project
  env       = var.env
  vpc       = var.vpc
  purpose   = "green"
  tg_config = "TG-GREEN"
}

module "listener_80" {
  source            = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-listener"
  port              = 80
  config            = "RULES-GREEN"
  load_balancer_arn = module.lb.arn
  target-group = {
    green = module.target-group-green.arn
  }
  depends_on = [
    module.lb,
    module.target-group-blue,
    module.target-group-green
  ]
}

module "listener_8080" {
  source            = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-listener"
  port              = 8080
  config            = "RULES-BLUE"
  load_balancer_arn = module.lb.arn
  target-group = {
    blue = module.target-group-blue.arn
  }
  depends_on = [
    module.lb,
    module.target-group-blue,
    module.target-group-green
  ]
}
