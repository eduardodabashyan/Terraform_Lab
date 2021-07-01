#Create Instance Security Group
resource "aws_security_group" "lamp_sec_group" {
  provider    = aws
  name        = "lamp_sec_group"
  description = "Allow 443 and 80 ports"
  vpc_id      = var.vpc_id 
  ingress {
    description = "Allow 443 port from anywhare"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 80 port from anywhare"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 80 port from anywhare"
    from_port   = 22
    to_port     = 22
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


#Create DB Security Group
resource "aws_security_group" "db_sec_group" {
  provider    = aws
  name        = "db_sec_group"
  description = "Allow 3306"
  vpc_id      = var.vpc_id
  ingress {
    description = "Allow 443 port from anywhare"
    from_port   = 3306
    to_port     = 3306
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


#Create ALB Security Group
resource "aws_security_group" "alb_sec_group" {
  provider    = aws
  name        = "alb_sec_group"
  description = "Allow 443 and 80 ports"
  vpc_id      = var.vpc_id
  ingress {
    description = "Allow 443 port from anywhare"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 80 port from anywhare"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 22 port from anywhare"
    from_port   = 22
    to_port     = 22
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
