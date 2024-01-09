# create cloudwatch log group #
resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/${var.project_name}-task-definition"

  lifecycle {
    create_before_destroy = false
  }
}
