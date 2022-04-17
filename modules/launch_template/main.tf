variable name{}
variable image_id{}
variable vpc_security_group_ids{ type = list}

resource "aws_launch_template" "autoscalling" {
  name = "${var.name}"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count       = 4
    threads_per_core = 2
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = true

  ebs_optimized = true



  elastic_inference_accelerator {
    type = "eia1.medium"
  }

  image_id = "${var.image_id}"

  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
  }

  instance_type = "t2.micro"  

  key_name = ""

  license_specification {
    license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  placement {
    availability_zone = "us-east-1"
  }

  vpc_security_group_ids = ${var.vpc_security_group_ids}

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

 # user_data = filebase64("${path.module}/example.sh")
}