variable availability_zone_1 {
  type        = string
  default     = "us-east-1a"
  description = "az1"
}

variable availability_zone_2 {
  type        = string
  default     = "us-east-1b"
  description = "az1"
}

variable availability_zone_list {
  type = list
  default = ["us-east-1a","us-east-1b"]
}

variable public_ip {
  type        = string
  default     = "0.0.0.0/0"  
}


variable vpc_cidr_block{
  type = string
  default = "10.0.0.0/16"
}

variable public_subnet_1{
  type = string
  default = "10.0.1.0/24"
}

variable public_subnet_2{
  type = string
  default = "10.0.2.0/24"
}

variable private_subnet_App_1{
  type = string
  default = "10.0.3.0/24"
}

variable private_subnet_App_2{
  type = string
  default = "10.0.4.0/24"
}

variable private_subnet_DB_1{
  type = string
  default = "10.0.5.0/24"
}

variable private_subnet_DB_2{
  type = string
  default = "10.0.6.0/24"
}