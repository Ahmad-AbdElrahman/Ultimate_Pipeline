variable "REGION" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "nodetags" {
  type = list(string)
  default = [ 
    "masternode",
    "workernode01",
    "workernode02",
     ]
}

variable "allow_inbound_ports" {
  type = map(any)
  default = {
    "Allow SSH" = 22,
    "Allow HTTP" = 80,
    "Allow HTTPS" = 443 
  }
}

variable "allow_outbound_ports" {
  type = map(any)
  default = { "allow all" = 0 }
}

variable "cidr_blocks_inbound" {
  type = list(string)
}

variable "cidr_blocks_outbound" {
  type = list(string)
}

variable "protocol_inbound" {
  type = string
}

variable "protocol_outbound" {
  type = string
}

