variable vpc_id {
  type        = string  
}

variable gateway_id {
    type      = string
}

variable cidr_block{
    type      = list
}

variable name{
    type = string
}

resource "aws_route_table" "route_table" {
  vpc_id = "${var.vpc_id}"

    route {
        cidr_block = "${var.cidr_block[0]}"
        gateway_id = "${var.gateway_id}"
    }
    route {
        cidr_block = "${var.cidr_block[1]}"
        gateway_id = "${var.gateway_id}"
    }
        

  tags = {
    Name = "${var.name}"
  }
}

output "route_table_id" {
  value       = "${aws_route_table.route_table.id}"  
}


