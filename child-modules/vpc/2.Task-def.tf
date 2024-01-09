# create task definition #
resource "aws_ecs_task_definition" "task-definition" {
  family                    = var.aws_ecs_task_definition
  execution_role_arn        = aws_iam_role.sika_iam_role.arn
  network_mode              = var.network_mode
  requires_compatibilities  = ["FARGATE"]
  cpu                       = 256
  memory                    = 1024

  container_definitions     = jsonencode([
    {
      name                  =  var.container_name
      image                 = "281056252627.dkr.ecr.eu-west-2.amazonaws.com/rocky-repository:latest"
      essential             = true

      portMappings          = [
        {
          containerPort     = var.containerPort
          hostPort          = var.hostPort
        }
      ]
      
      ulimits = [
        {
          name = "nofile",
          softLimit = 1024000,
          hardLimit = 1024000
        }
      ]

      logConfiguration = {
        logDriver   = "awslogs",
        options     = {
          "awslogs-group"          = aws_cloudwatch_log_group.log_group.name,
           "awslogs-region"        = var.region,
          "awslogs-stream-prefix"  = "ecs"
        }
      }
    }
  ])
}
