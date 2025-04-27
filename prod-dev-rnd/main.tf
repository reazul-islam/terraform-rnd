terraform {
  cloud {
    organization = "reazuls"

    workspaces {
      tags = ["reazuls"]
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Create a security group to allow HTTP (port 80) and SSH (port 22) traffic
resource "aws_security_group" "web_sg" {
  name        = "${var.instance_name}-sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = var.vpc_id  # You can pass your VPC id as a variable

  # Allow HTTP traffic (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere
  }

  # Allow SSH traffic (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound
  }
}


# Create EC2 instance
resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<h1>Hello World from Terraform Web Server (Ubuntu)!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = var.instance_name
    Env  = var.environment
  }
}

# Create an Elastic IP (EIP)
resource "aws_eip" "web_eip" {
  instance = aws_instance.web_server.id
  vpc      = true
}

