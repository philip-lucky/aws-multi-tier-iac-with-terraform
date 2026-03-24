module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.0"

  name = "my-portfolio-vpc"
  cidr = "10.0.0.0/16"

  # Spanning 2 Availability Zones for High Availability
  azs             = ["eu-north-1a", "eu-north-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Enable NAT Gateway for private instances to reach the internet
  enable_nat_gateway = true
  single_nat_gateway = true # Keeps costs down to just 1 NAT Gateway

  # Enable DNS hostnames (needed for RDS and EC2 later)
  enable_dns_hostnames = false
  enable_dns_support   = false
}
