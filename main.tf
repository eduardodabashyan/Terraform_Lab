terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}


provider "aws" {
  profile = var.profile
  region  = lookup(var.region, local.env)
}

data "template_file" "server_configs" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    book_dbhostname  = module.db.book_db
    movie_dbhostname = module.db.movie_db
  }
}

#Create keypair for logging into EC2 instance
resource "aws_key_pair" "aws_key" {
  # provider   = aws
  key_name   = "Instance_ssh_key"
  public_key = file("C:\\Users\\Eduard_Odabashyan/.ssh/id_rsa.pub")
}


module "compute" {
  source = "./compute"

  instance-type = var.instance-type
  ami-id        = lookup(var.ami-id, local.env)
  vpc_id        = module.network.vpc_id
  aws_key       = aws_key_pair.aws_key.id
  sub_1         = module.network.sub_1
  template      = data.template_file.server_configs.rendered
}

module "db" {
  source = "./db"

  movie_dbadmin = var.movie_dbadmin
  movie_dbpass  = var.movie_dbpass
  book_dbadmin  = var.book_dbadmin
  book_dbpass   = var.book_dbpass
  db_sg         = module.compute.db_sg
  sub_1         = module.network.sub_1
  sub_2         = module.network.sub_2

}

module "network" {
  source = "./network"
  region = lookup(var.region, local.env) 
}

#Create Application Load Balancer
resource "aws_lb" "lamp_alb" {
  name               = "lamp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.compute.alb_sg_id]
  subnets            = [module.network.sub_1, module.network.sub_2]

  #enable_deletion_protection = true

  tags = {
    Name = "LAMP ALB"
  }
}

#Create Target Group for ALB
resource "aws_lb_target_group" "tf-alb-tg" {
  name     = "tf-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id
}


# #Create Target Group Attachment
# resource "aws_lb_target_group_attachment" "alb-tg-attachment" {
#   target_group_arn = aws_lb_target_group.tf-alb-tg.arn
#   target_id        = aws_autoscaling_group.lamp-asg.id # module.compute.app_server_id
#   port             = 80
# }


#Create Lunch Tamplaate for ASG
resource "aws_launch_template" "asg-lt" {
  name_prefix   = "asg-lt"
  image_id      = lookup(var.ami-id, local.env) 
  instance_type = var.instance-type
  user_data     = base64encode("${data.template_file.server_configs.rendered}")
  key_name      = aws_key_pair.aws_key.id
  
 
  network_interfaces {
   # associate_public_ip_address = true
    security_groups             = [module.compute.app_sg]
  #   subnet_id                   = module.network.sub_1
  }

  # tags = {
  #   Name = "Application Instance"
  # }
}


#Create ASG
resource "aws_autoscaling_group" "lamp-asg" {
  # name               = "Application Instance"
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = [module.network.sub_1, module.network.sub_2]
  target_group_arns = [aws_lb_target_group.tf-alb-tg.arn]

  launch_template {
    id      = aws_launch_template.asg-lt.id
    version = "$Latest"
  }
}


#Create ALB Listener
resource "aws_lb_listener" "lamp-alb-listener" {
  load_balancer_arn = aws_lb.lamp_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-alb-tg.arn
  }
}