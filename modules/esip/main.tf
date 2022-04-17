resource "aws_eip" "lb" {  
  vpc      = true
}

output id {
  value       =   "${aws_eip.lb.id}"
}
