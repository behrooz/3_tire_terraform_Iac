variable subnet_id {
  type        = string  
}
variable name {
  type        = string  
}
variable id {
    type      = string
}

resource "aws_nat_gateway" "natgateway" {
  allocation_id = "${var.id}"
  subnet_id     = "${var.subnet_id}"

  tags = {
    Name = "${var.name}"
  }
}

output id{
    value = "${aws_nat_gateway.natgateway.id}"
}