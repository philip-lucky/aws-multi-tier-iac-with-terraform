# 1. database Security Group (Only allows MySQL traffic from the Web EC2 instances)
resource "aws_security_group" "db_sg" {
  name   = "db-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id] # Links back to your Compute SG
  }
}

# 2. DB Subnet Group (Tells AWS which private subnets to place the DB in)
resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet-group"
  subnet_ids = module.vpc.private_subnets
}

# 3. The RDS Instance
resource "aws_db_instance" "db" {
  identifier             = "portfolio-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "SuperSecretPass123!" # Note: Use AWS Secrets Manager in real production!
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  
  multi_az               = true # Fulfills the "highly available" requirement
  skip_final_snapshot    = true # Allows you to easily run 'terraform destroy' later without errors
}
