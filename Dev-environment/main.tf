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
  identifier             = var.identifier
  username               = var.username
  engine_version         = var.engine_version
  nat_gateway_route_cidr = var.nat_gateway_route_cidr
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




