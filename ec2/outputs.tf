output "ip_public" {
    value = module.ec2-instance.public_ip
}
output "key_name" {
    value = module.ec2-instance.key_name
}