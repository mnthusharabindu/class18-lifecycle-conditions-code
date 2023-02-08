resource "aws_instance" "public_servers" {
  #count                       = 3
  count                       = local.newenv == "Dev" ? 3 : 1
  ami                         = lookup(var.ami, var.aws_region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "${var.vpc_name}-PublicServer-${count.index + 1}"
    Env  = var.environment
  }
  user_data = <<-EOF
		#!/bin/bash
        sudo apt-get update
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
        echo "<h1>${var.vpc_name}-PublicServer-${count.index + 1}</h1>" | sudo tee -a /var/www/html/index.html
	EOF
}