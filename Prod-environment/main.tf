# Calling from child-module #

module "vpc" {
  source = "../child-modules/vpc"

  project_name           = var.project_name
  region                 = var.region
  instance_tenancy       = var.instance_tenancy
  instance_class         = var.instance_class
  instance_type          = var.instance_type
  ami                    = var.ami
  vpc_cidr_block         = var.vpc_cidr_block
  enable_dns_hostnames   = var.enable_dns_hostnames
  enable_dns_support     = var.enable_dns_support
  pubsub_cidrs           = var.pubsub_cidrs
  ptesub_cidrs           = var.ptesub_cidrs
  storage_type           = var.storage_type
  nat_gateway_route_cidr = var.nat_gateway_route_cidr
  identifier             = var.identifier
  username               = var.username
  engine_version         = var.engine_version
  allocated_storage      = var.allocated_storage
  inbound_ports          = var.inbound_ports
  outbound_ports         = var.outbound_ports
  domain_name            = var.domain_name
  alternative_name       = var.alternative_name
  key_name               = var.key_name
  container_name         = var.container_name
  containerPort          = var.containerPort
  hostPort               = var.hostPort
  load_balancer_type     = var.load_balancer_type
  target_type            = var.target_type
  skip_final_snapshot    = var.skip_final_snapshot
  engine                 = var.engine
  password               = var.password
  cluster_name           = var.cluster_name
  publicly_accessible    = var.publicly_accessible
  records                = var.records
  validation_method      = var.validation_method
  private_zone           = var.private_zone
  network_mode           = var.network_mode
  aws_ecs_task_definition = var.aws_ecs_task_definition
  listener_port           = var.listener_port 
  protocol                = var.protocol 
}

#Create a hosted zone for RT 53 #

data "aws_route53_zone" "selected" {
  name = var.domain_name
  
}


# Create Route53 A record #

resource "aws_route53_record" "route53-record-dns" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "www.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = var.records

}


# Get details about RT 53 hosted zone #

data "aws_route53_zone" "hosted_zone" {
  name         = var.domain_name
  private_zone = var.private_zone
}


# Create a record set for route53 domain validation #

resource "aws_route53_record" "route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
}

# validating acm/ssl certificate #

resource "aws_acm_certificate_validation" "certificate" {
  certificate_arn         = aws_acm_certificate.acm_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]

}



# # create a listener on port 443 with forward action #

# resource "aws_lb_listener" "lb_https_listener" {
#   load_balancer_arn  = module.vpc.load_balancer_arn
#   port               = 443
#   protocol           = "HTTPS"
#   ssl_policy         = "ELBSecurityPolicy-2016-08"
#   certificate_arn    = aws_acm_certificate.acm_certificate.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = module.vpc.target_group_arn
#   }
# }

# # create a listener on port 80 with redirect action #

# resource "aws_lb_listener" "lb_http_listener" {
#   load_balancer_arn =  aws_lb.sika-lb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = 443
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

# Req a certificate from ACM #

resource "aws_acm_certificate" "acm_certificate" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = var.validation_method

  lifecycle {
    create_before_destroy = true
  }
}