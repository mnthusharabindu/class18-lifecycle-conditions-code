aws_region    = "us-east-1"
vpc_cidr      = "10.30.0.0/16"
vpc_name      = "devfunc"
key_name      = "DevOps"
azs           = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_cidrs  = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24", "10.30.4.0/24"]
private_cidrs = ["10.30.10.0/24", "10.30.20.0/24", "10.30.30.0/24", "10.30.40.0/24"]
environment   = "dev"
instance_type = "t2.micro"
ami = {
  us-east-1 = "ami-0b0dcb5067f052a63"
  us-east-2 = "ami-0beaa649c482330f7"
}

