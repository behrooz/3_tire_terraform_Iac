provider "aws"{
    region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block = "${var.vpc_cidr_block}"
}

module "public_subnet_1" {
    source = "./modules/subnet"
    vpc_id = "${module.vpc.vpc_id}"
    availability_zone_list = "${var.availability_zone_list[0]}" 
    subnet_cidr_block = "${var.public_subnet_1}"
    name = "public_subnet_1"
}

module "public_subnet_2" {
    source = "./modules/subnet"
    vpc_id = "${module.vpc.vpc_id}"
    availability_zone_list = "${var.availability_zone_list[1]}" 
    subnet_cidr_block = "${var.public_subnet_2}"
    name = "public_subnet_2"
}

module "private_subnet_1" {
    source = "./modules/subnet"
    vpc_id = "${module.vpc.vpc_id}"
    availability_zone_list = "${var.availability_zone_list[0]}" 
    subnet_cidr_block = "${var.private_subnet_App_1}"
    name = "private_subnet_App_1"
}

module "private_subnet_2" {
    source = "./modules/subnet"
    vpc_id = "${module.vpc.vpc_id}"
    availability_zone_list = "${var.availability_zone_list[1]}" 
    subnet_cidr_block = "${var.private_subnet_App_2}"
    name = "private_subnet_App_2"
}

module "private_subnet_3" {
    source = "./modules/subnet"
    vpc_id = "${module.vpc.vpc_id}"
    availability_zone_list = "${var.availability_zone_list[0]}" 
    subnet_cidr_block = "${var.private_subnet_DB_1}"
    name = "private_subnet_DB_1"
}

module "private_subnet_4" {
    source = "./modules/subnet"
    vpc_id = "${module.vpc.vpc_id}"
    availability_zone_list = "${var.availability_zone_list[1]}" 
    subnet_cidr_block = "${var.private_subnet_DB_2}"
    name = "private_subnet_DB_2"
}

module "igw" {
  source = "./modules/igw"
  vpc_id = "${module.vpc.vpc_id}"
  name  = "3tire-Architure-IGW"
}

module "route_table" {
    source      = "./modules/public_routetable"
    vpc_id      = "${module.vpc.vpc_id}"
    gateway_id      = "${module.igw.igw_id}"
    cidr_block  = ["${var.public_ip}"]
    name        = "public_route_table"
}

module "elastic_ip_1" {
    source = "./modules/esip"
}

module "elastic_ip_2" {
    source = "./modules/esip"
}

module "public_natgateway_1" {
    source        = "./modules/natgw"
    subnet_id     = "${module.public_subnet_1.subnet_id}"
    id            = "${module.elastic_ip_1.id}"
    name          = "public_natgateway_1"
}

module "public_natgateway_2" {
    source        = "./modules/natgw"
    subnet_id     = "${module.public_subnet_2.subnet_id}"
    id            = "${module.elastic_ip_2.id}"
    name          = "public_natgateway_2"
}

module "route_table_association_public_1" {
    source          = "./modules/public_route_table_association"
    subnet_id       = "${module.public_subnet_1.subnet_id}"
    route_table_id  = "${module.route_table.route_table_id}"
}

module "route_table_association_public_2" {
    source          = "./modules/public_route_table_association"
    subnet_id       = "${module.public_subnet_2.subnet_id}"
    route_table_id  = "${module.route_table.route_table_id}"
}

module "private_route_table_az1" {
    source          = "./modules/private_routetable"
    vpc_id          = "${module.vpc.vpc_id}"
    gateway_id      = "${module.public_natgateway_1.id}"
    cidr_block      = ["${var.private_subnet_App_1}","${var.private_subnet_DB_1}"]
    name            = "private_route_table_az1"
}

module "route_table_association_private_1" {
    source          = "./modules/public_route_table_association"
    subnet_id       = "${module.private_subnet_1.subnet_id}"
    route_table_id  = "${module.private_route_table_az1.route_table_id}"
}

module "route_table_association_private_2" {
    source          = "./modules/public_route_table_association"
    subnet_id       = "${module.private_subnet_3.subnet_id}"
    route_table_id  = "${module.private_route_table_az1.route_table_id}"
}

module "private_route_table_az2" {
    source          = "./modules/private_routetable"
    vpc_id          = "${module.vpc.vpc_id}"
    gateway_id      = "${module.public_natgateway_2.id}"
    cidr_block      = ["${var.private_subnet_App_2}","${var.private_subnet_DB_2}"]
    name            = "private_route_table_az2"
}

module "route_table_association_private_3" {
    source          = "./modules/public_route_table_association"
    subnet_id       = "${module.private_subnet_2.subnet_id}"
    route_table_id  = "${module.private_route_table_az2.route_table_id}"
}

module "route_table_association_private_4" {
    source          = "./modules/public_route_table_association"
    subnet_id       = "${module.private_subnet_4.subnet_id}"
    route_table_id  = "${module.private_route_table_az2.route_table_id}"
}

module "sg_group" {
    source          = "./modules/security_group"
    name            = "test sg"
    desc            = "test desc"
    ingress_ports   = [
        {
            from_port   = 80
            to_port     = 81
            protocol    = "tcp"
            cidr_blocks = ["10.0.1.0/24"]
        },
        {
            from_port   = 8080
            to_port     = 8080
            protocol    = "tcp"
            cidr_blocks = ["10.0.2.0/24"]
        }
    ]
    vpc_id          = "${module.vpc.vpc_id}"
}

# module "s3_website" {
#     source = "./modules/s3_website"
#     name   = "tests3websitetestbehroozterrafomr"
#     acl    = "public-read"
# }

module "ec2-intance" {
    source          = "./modules/ec2"
    name            = "OnlyaName"
    ami             = "ami-0c02fb55956c7d316"
    instance_type   = "t2.micro"
    volume_type     = "gp3"
    subnet_id       = "${module.private_subnet_1.subnet_id}"
    key_name        = ""
    vpc_security_group_ids  = ["${module.sg_group.id}"]
}

module "ami_from_instanc" {
    source              = "./modules/ami"
    name                = "javaEnvApp"
    source_instance_id  = "${module.ec2-intance.instance_id}"  
}

module "luanch_template" {
    source      = "./modules/launch_template"
    name        = "just_a_name"
    image_id    = "${module.ami_from_instanc.instance_id}"
    vpc_security_group_ids  = ["${module.sg_group.id}"]
    
}