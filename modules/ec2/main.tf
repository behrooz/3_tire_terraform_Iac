variable name{}
variable ami{}
variable instance_type{}
variable subnet_id{}
variable key_name{}
variable vpc_security_group_ids {type = list}
variable volume_type{}

resource "aws_instance" "ec2-intance" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"  
  key_name = "${var.key_name}"


  vpc_security_group_ids = "${var.vpc_security_group_ids}"
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "${var.volume_type}"
  }
  
  tags = {
    Name ="${var.name}"
    # Environment = "DEV"
    # OS = "UBUNTU"
    # Managed = "IAC"
  }
  
  user_data = <<-EOL
    #!/bin/bash -xe
    sudo yum update
    sudo yum install java-11-amazon-corretto-headless
  EOL

  
}

output "instance_id" {
  value = aws_instance.ec2-intance.id
}