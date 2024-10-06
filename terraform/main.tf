resource "tls_private_key" "master_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key" {
  filename = "../ssh_key/master_ssh_key.pem"
  content  = tls_private_key.master_ssh_key.private_key_pem
  file_permission = "0400"  
}

resource "aws_key_pair" "master_key" {
  key_name = "masterkey"
  public_key = tls_private_key.master_ssh_key.public_key_openssh
}
resource "aws_instance" "aws_nodes" {
  ami = var.ami
  instance_type = var.instance_type
  availability_zone = var.availability_zone
  key_name = aws_key_pair.master_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_inbound_outbound.id]
  tags = {
    Name = each.value
  }
  for_each = toset(var.nodetags)
}

resource "aws_security_group" "allow_inbound_outbound" {
  name        = "allow_inbound_outbound"
  description = "Allow inbound traffic and all outbound traffic"

  dynamic "ingress" {
    for_each = var.allow_inbound_ports
    content {
      description = ingress.key
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.protocol_inbound
      cidr_blocks = var.cidr_blocks_inbound
    }

  }

  dynamic "egress" {
    for_each = var.allow_outbound_ports
    content {
      description = egress.key
      from_port   = egress.value
      to_port     = egress.value
      protocol    = var.protocol_outbound  # -1 means all protocols
      cidr_blocks = var.cidr_blocks_outbound
    }
  }
  
  tags = {
    Name = "nodes-sg"
  }
}