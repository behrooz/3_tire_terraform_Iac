
# 3-Tire architecture design in AWS
#### Introduction
Most of the applications needs to have separate layers in their infrastructure, a 3-tire architecture split infrastructure into three logical layers.
- Presentation layer
- Business layer
- Data storage layers


#### In this design we are going to use below services

- [AWS VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
- [AWS Subnet](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html)
- [AWS Internet gatway](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)
- [AWS Nat gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)
- [AWS LoadBalancer](https://aws.amazon.com/elasticloadbalancing/)
- [AWS EC2 instance](https://aws.amazon.com/ec2/)
- [AWS Security group](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)

## Prerequisites
you need to install terraform  check out this [link](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
