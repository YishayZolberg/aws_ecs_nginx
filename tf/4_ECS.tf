#CREATE ECS CLUSTER
resource "aws_ecs_cluster" "cluster" {
  name = "yz-ecs-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

#create ecs service for nginx task
resource "aws_ecs_service" "ngnix_service" {
  name = "nginx_service"
  cluster = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.id
  #execution_role_arn       = aws_iam_role.ecs_task_role.arn
  desired_count = 1
  launch_type = "FARGATE"
  platform_version = "LATEST"
  
  load_balancer {
    
    target_group_arn = aws_lb_target_group.my-tg.arn
    container_name   = "nginx"
    container_port   = 80
  }
  
  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.private_sg.id]
    subnets          = [aws_subnet.private_subnets-1.id]
  }
  lifecycle {
    ignore_changes = [task_definition]
  }
}

#task definition for nginx image
resource "aws_ecs_task_definition" "task" {
  execution_role_arn = aws_iam_role.ecs_task_role.arn
  family = "nginx_service"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = 512
  memory = 2048
  container_definitions = <<DEFINITION
  [
    {
      "name"      : "nginx",
      "image"     : "371112660823.dkr.ecr.us-east-1.amazonaws.com/nginx-commit:latest",
      "cpu"       : 512,
      "memory"    : 2048,
      "essential" : true,
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort"      : 80
        }
      ]
    }
  ]
  DEFINITION
}