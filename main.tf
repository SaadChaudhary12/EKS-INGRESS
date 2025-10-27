################################################################################
# AVAILABILITY ZONES
################################################################################

data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

################################################################################
# MODULE-VPC
################################################################################

module "vpc" {
  source           = "./module/vpc"
  name             = local.name
  vpc_cidr         = local.vpc_cidr
  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  route_table_cidr = local.route_table_cidr
}

################################################################################
# MODULE-RDS
################################################################################

module "rds" {
  source               = "./module/rds"
  name                 = "Saad-Rds"
  allocated_storage    = local.storage
  engine               = local.engine
  engine_version       = local.engine_version
  instance_class       = local.instance_class
  db_name              = local.db_name
  username             = local.username
  password             = local.password
  db_sg_id             = aws_security_group.db_sg.id
  db_subnet_group_name = aws_db_subnet_group.mains.name
}

resource "aws_db_subnet_group" "mains" {
  name                 = local.db_subnet_gn
  subnet_ids           = module.vpc.private_ids
}

################################################################################
# MODULE-LOAD BALANCER
################################################################################

module "alb" {
  source            = "./module/alb"
  lb_name           = local.lb_name
  lb_type           = local.lbt
  security_group_id = aws_security_group.lb_sg.id
  subnet_ids        = module.vpc.public_ids
  vpc_id            = module.vpc.vpc_id
  target_group_name = local.target_group_name
  app_port          = local.app_port
  health_check_path = local.health_check_path
}

################################################################################
# MODULE-EKS CLUSTER
################################################################################

module "eks" {
  source            = "./module/eks"

  cluster_name      = local.cluster_name
  cluster_version   = local.cluster_version
  subnet_ids        = module.vpc.public_ids
  vpc_id            = module.vpc.vpc_id

  node_group_name   = local.node_group_name
  instance_types    = local.instance_types
  capacity_type     = local.capacity_type

  min_size          = local.min_size
  max_size          = local.max_size
  desired_size      = local.desired_size
}

################################################################################
# SECURITY-GROUP FOR LOAD-BALANCER
################################################################################

resource "aws_security_group" "lb_sg" {
  vpc_id        = module.vpc.vpc_id
  name_prefix   = local.name_prefix_lb

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################
# SECRETS
################################################################################

module "secrets_manager" {
  source         = "./module/secret"
  secret_name    = local.secret_name
  db_username    = local.db_username
  db_password    = local.db_password
  db_name        = local.db_name
  db_host        = split(":", module.rds.endpoint)[0]
}

################################################################################
# ALB-INGRESS
################################################################################


module "alb_ingress" {
  source              = "./module/alb-ingress"
  cluster_name        = module.eks.cluster_name
  cluster_endpoint    = module.eks.cluster_endpoint
  cluster_ca_data     = module.eks.cluster_ca_data
  oidc_provider_url   = module.eks.oidc_provider_url
  oidc_provider_arn   = module.eks.oidc_provider_arn
  vpc_id              = module.vpc.vpc_id
  region              = local.region
}


################################################################################
# SECURITY-GROUP FOR APPLICATION / EC2
################################################################################

resource "aws_security_group" "web_sg" {
  vpc_id            = module.vpc.vpc_id
  name_prefix       = local.name_prefix_web

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  ingress {
    description     = "from ALB"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################
# SECURITY-GROUP FOR DATA-BASE
################################################################################

resource "aws_security_group" "db_sg" {
  vpc_id = module.vpc.vpc_id
  name   = local.name_prefix_db

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [
      aws_security_group.web_sg.id,
      ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
