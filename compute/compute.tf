# #Create instance
# resource "aws_instance" "app_server" {
#   #provider      = aws
#   instance_type = var.instance-type
#   ami           = var.ami-id
#   key_name      = var.aws_key #aws_key_pair.aws_key.id
#   # "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20200908"

#   # vpc_id                      = var.vpc_id
#   subnet_id                   = var.sub_1 #aws_subnet.subnet_1.id
#   user_data                   = var.template # data.template_file.server_configs.rendered
#   vpc_security_group_ids      = [aws_security_group.lamp_sec_group.id]
#   associate_public_ip_address = true

#   tags = {
#     Name = "Application Instance"
#   }
# }