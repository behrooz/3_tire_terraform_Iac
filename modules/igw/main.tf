variable vpc_id {
  type        = string  
}

variable name {
  type        = string  
}


resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.name}"
  }
}

output igw_id {
  value       = "${aws_internet_gateway.gw.id}"  
}
