resource "aws_db_subnet_group" "default" {
  name       = "devopsb30subnetgroup"
  subnet_ids = [aws_subnet.public-subnets.0.id, aws_subnet.public-subnets.1.id, aws_subnet.public-subnets.2.id]
  tags = {
    Name = "DevOpsB30SubnetGroup"
  }
}

#Importing DB Secrets From Secret Manager
data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "devopsb30secret1"
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

resource "aws_db_instance" "myrds1" {
  allocated_storage    = 10
  identifier           = "myrds1" #Uncomment This Before Deploying.
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t2.medium"
  db_name              = "devopsb29instance1"
  db_subnet_group_name = aws_db_subnet_group.default.name
  # Manually Created secrets from AWS Secrets Manager
  username = local.db_creds.username
  password = local.db_creds.password
  #final_snapshot_identifier = true
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  depends_on             = [aws_db_subnet_group.default]
  lifecycle {
    prevent_destroy = false
    ignore_changes  = [tags, ]
  }
}