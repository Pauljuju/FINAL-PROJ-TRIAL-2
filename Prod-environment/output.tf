output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets_id" {
  value = module.vpc.public_subnets_id
}

output "private_subnets_id" {
  value = module.vpc.private_subnets_id
}

output "domain_name" {
  value = var.domain_name
}

output "certificate_arn" {
  value = aws_acm_certificate.acm_certificate.arn
}

# output "load_balancer_arn" {
#   value = aws_lb.sika-lb.arn
# }

# output "target_group_arn" {
#   value = aws_lb_target_group.sika-TgtGP.arn
# }