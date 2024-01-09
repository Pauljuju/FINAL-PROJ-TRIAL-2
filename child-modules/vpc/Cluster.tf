  # aws cluster #

resource "aws_ecs_cluster" "sika-cluster" {
  name = "${var.project_name}-cluster"

  setting {
    name    = "containerInsights"
    value   = "disabled"
  }
}