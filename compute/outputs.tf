output "app_sg" {
    value = aws_security_group.lamp_sec_group.id
}


output "alb_sg_id" {
    value = aws_security_group.alb_sec_group.id
} 

# output "app_server_id" {
#     value = aws_instance.app_server.id
# }

output "db_sg" {
    value = aws_security_group.db_sec_group.id
}