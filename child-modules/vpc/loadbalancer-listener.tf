#  create application load balancer #

resource "aws_lb" "sika-lb" {
  name               = "${var.project_name}-lb"
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.sika-sg.id]
  subnets            = aws_subnet.sika_pubsub[*].id
   tags   = {
    Name = "${var.project_name}-lb"
   }
}

# create a listener on port 80 with redirect action #

resource "aws_lb_listener" "sika-listener" {
  load_balancer_arn = aws_lb.sika-lb.arn
  port              = var.listener_port
  protocol          = var.protocol
    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sika-TgtGP.arn
  }
}




