module "ecs_cluster" {
  source  = "git::https://github.com/von-salumbides/terraform-module.git//aws-ecs-cluster"
  project = var.project
  env     = var.env
}

module "aws_ecs_service" {
  source                      = "git::https://github.com/von-salumbides/terraform-module.git//aws-ecs-service"
  config                      = "ECS"
  env                         = var.env
  project                     = var.project
  region                      = var.region
  cluster                     = module.ecs_cluster.name
  subnet_list                 = var.subnet_list
  app_name                    = module.codedeploy_app.name
  security_groups             = module.security_group_ecs.id
  task_role_arn               = module.iam_role_tasks.arn
  execution_role_arn          = module.iam_role_exec.arn
  codedeploy_service_role_arn = module.iam_role_codedeploy.arn
  prod_traffic_route          = module.lb.listener_80_arn
  test_traffic_route          = module.lb.listener_8080_arn
  target_group_green_arn      = {
    api = "${module.target_group_green.arn}"
  }
  target_group_green = {
    api = "${module.target_group_green.name}"
  }
  target_group_blue = {
    api = "${module.target_group_blue.name}"
  }
}

