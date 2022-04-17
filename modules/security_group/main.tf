variable vpc_id{}
variable name{}
variable desc{}

variable ingress_ports {
  type = list(object({
      from_port   = string
      to_port     = string
      protocol    = string
      cidr_blocks = list(string)
  }))  

  # here is a sample as default
  # default = [
  #   {
  #     from_port   = 80
  #     to_port     = 81
  #     protocol    = "tcp"
  #     cidr_blocks = ["10.0.1.0/24"]
  #   },
  #   {
  #     from_port   = 8080
  #     to_port     = 8080
  #     protocol    = "tcp"
  #     cidr_blocks = ["10.0.2.0/24"]
  #   }
  # ]
}

resource "aws_security_group" "allow_defaults" {
  name        = "${var.name}"
  description = "${var.desc}"
  vpc_id      = "${var.vpc_id}"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value["from_port"]
      to_port     = port.value["to_port"]
      protocol    = port.value["protocol"]
      cidr_blocks = port.value["cidr_blocks"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name}"
  }
}

output id{
    value = "${aws_security_group.allow_defaults.id}"
}