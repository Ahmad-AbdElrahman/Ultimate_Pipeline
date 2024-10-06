output "PublicIP" {
  value = { for key, instance in aws_instance.aws_nodes : key => instance.public_ip }
}

output "PrivateIP" {
  value = { for key, instance in aws_instance.aws_nodes : key => instance.private_ip }
}