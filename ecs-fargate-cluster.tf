##1- create ECS fargate cluster on AWS##
provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "fargate_cluster" {
  name = "my-fargate-cluster"
}

resource "aws_ecs_task_definition" "fargate_task" {
  family                   = "my-fargate-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "my-fargate-container"
      image     = "nginx"
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "fargate_service" {
  name            = "my-fargate-service"
  cluster         = aws_ecs_cluster.fargate_cluster.id
  task_definition = aws_ecs_task_definition.fargate_task.arn
  desired_count   = 2

  network_configuration {
    subnets          = ["subnet-0a42ba021bc7c99ff", "subnet-07edc5787ec8285d5"]
    security_groups  = ["sg-04ff7710ce5ff95b8"]
  }
}
######################
## 2- create image registry ##

resource "aws_ecr_repository" "my_ecr_repo" {
  name = "my-ecr-repo"
}

