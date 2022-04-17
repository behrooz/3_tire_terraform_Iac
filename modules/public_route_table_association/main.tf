variable "subnet_id" {
    type    = string
}

variable "route_table_id" {
    type    = string
}

resource "aws_route_table_association" "route_subnet" {
  subnet_id      = "${var.subnet_id}"
  route_table_id = "${var.route_table_id}"
}