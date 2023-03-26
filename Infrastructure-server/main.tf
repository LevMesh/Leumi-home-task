terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
    required_version = ">= 1.2.0"
}

provider "aws" {
    region  = var.aws_region
}



resource "aws_instance" "py-server" {
  
  ami                   = var.ami_type
  instance_type         = var.instance_type
  key_name              = "leumi"
  user_data             = "${file("installations.sh")}"
  associate_public_ip_address         = true
  security_groups = [aws_security_group.py-sg.id]
  subnet_id = aws_subnet.py-sub.id

  root_block_device {
    volume_size = 20 # in GB <<----- I increased this!
    volume_type = "gp2"
  }
  tags = var.additional_tags
}


########################################
#------------- Networking -------------#
########################################


resource "aws_security_group" "py-sg" {
  name        = "python-server-sg"
  description = "Security group for production python server"
  vpc_id      = aws_vpc.py-vpc.id

    ingress {
      description = "Allow HTTPS"
      from_port   = 8080
      to_port     = 8080
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      description = "Allow ssh"
      from_port   = 22
      to_port     = 22
      protocol    = "ssh"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      description      = "Allow HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    #   cidr_blocks = ["<my_private_ip>/32"]
      ipv6_cidr_blocks = ["::/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

}




resource "aws_vpc" "py-vpc" {

    cidr_block = "10.5.5.0/24"
    instance_tenancy = "default"

    tags = var.additional_tags
}

# Define subnet-1 in our VPC
resource "aws_subnet" "py-sub" {

    vpc_id            = aws_vpc.py-vpc.id
    cidr_block        = "10.5.5.16/28"
    availability_zone = "${var.aws_region}a" ### change "a" according to your az reference ###

    tags = var.additional_tags
}

# Define our IGW
resource "aws_internet_gateway" "py-IGW" {
    vpc_id = aws_vpc.py-vpc.id

    tags = var.additional_tags

}

# Define our Route-Table
resource "aws_route_table" "py-rt" {
    vpc_id = aws_vpc.py-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.py-IGW.id
    }

    tags = var.additional_tags

}

# associate our Route-Table & Internet-Getway 
resource "aws_main_route_table_association" "igw-rt" {
    vpc_id         = aws_vpc.py-vpc.id
    route_table_id = aws_route_table.py-rt.id
}




output "python-server" {
  value = "http://${aws_instance.py-server.public_ip}" 
}
