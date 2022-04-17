variable vpc_cidr_block{}

resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr_block}"
  
  tags = {
    Name = "3tire-architecture"
  }
}

output "vpc_id" {
  value       = "${aws_vpc.main.id}" 
}