variable name{}
variable source_instance_id{}

resource "aws_ami_from_instance" "ami" {
  name               = "${var.name}"
  source_instance_id = "${var.source_instance_id}"
  tags = {
      Name = "${var.name}"
  }
}

output instance_id {
    value = "${aws_ami_from_instance.ami.id}"
}