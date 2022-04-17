
variable vpc_id {
  type        = string  
}

variable subnet_cidr_block {
  type        = string  
}

variable name {
  type        = string  
}

variable availability_zone_list{ }

resource "aws_subnet" "main" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr_block}"
  availability_zone = "${var.availability_zone_list}"
  tags = {
    Name = "${var.name}"
  }
}

output "subnet_id" {
  value   = "${aws_subnet.main.id}"
}