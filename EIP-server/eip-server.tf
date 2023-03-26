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



resource "aws_instance" "eip-server" {
  
  ami                   = var.ami_type
  instance_type         = var.instance_type
  key_name              = "leumi"
  user_data             = "${file("installations.sh")}"
  security_groups = [aws_security_group.eip-sg.id]
  subnet_id = aws_subnet.eip-sub.id

  root_block_device {
    volume_size = 20 # in GB <<----- I increased this!
    volume_type = "gp2"
  }
}


########################################
#------------- Networking -------------#
########################################


resource "aws_security_group" "eip-sg" {
  name        = "python-server-sg"
  description = "Security group for production python server"
  vpc_id      = aws_vpc.eip-vpc.id

    ingress {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["46.121.54.205/32" ,  "91.231.246.50/32"]
    }

    # ingress {
    #   description      = "Allow ssh"
    #   from_port        = 22
    #   to_port          = 22
    #   protocol         = "TCP"
    #   cidr_blocks = ["0.0.0.0/0"]
    # #   cidr_blocks = ["<my_private_ip>/32"]
    #   ipv6_cidr_blocks = ["::/0"]
    # }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_vpc" "eip-vpc" {

    cidr_block = "10.5.5.0/24"
    instance_tenancy = "default"

    tags = var.additional_tags
}

# Define subnet-1 in our VPC
resource "aws_subnet" "eip-sub" {

    vpc_id            = aws_vpc.eip-vpc.id
    cidr_block        = "10.5.5.16/28"
    availability_zone = "${var.aws_region}a" ### change "a" according to your az reference ###

    tags = var.additional_tags
}

# Define our IGW
resource "aws_internet_gateway" "eip-IGW" {
    vpc_id = aws_vpc.eip-vpc.id

    tags = var.additional_tags

}

# Define our Route-Table
resource "aws_route_table" "eip-rt" {
    vpc_id = aws_vpc.eip-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eip-IGW.id
    }

    tags = var.additional_tags

}

# associate our Route-Table & Internet-Getway 
resource "aws_main_route_table_association" "igw-rt" {
    vpc_id         = aws_vpc.eip-vpc.id
    route_table_id = aws_route_table.eip-rt.id
}


#Create an Elastic IP
resource "aws_eip" "eip-server" {
  vpc = true
}

#Associate EIP with EC2 Instance
resource "aws_eip_association" "demo-eip-association" {
  instance_id   = aws_instance.eip-server.id
  allocation_id = aws_eip.eip-server.id
}




resource "aws_lb" "test" {
  name               = "test-lb-tf"
#   internal           = false
  load_balancer_type = "network"
#   subnets            = [aws_subnet.eip-sub.id]


  subnet_mapping {
    subnet_id     = aws_subnet.eip-sub.id
    allocation_id = aws_eip.eip-server.id
  }

#   enable_deletion_protection = true

  tags = var.additional_tags

}


output "elastic_ip" {
  value = aws_eip.eip-server.public_ip
}


# output "python-server" {
#   value = "http://${aws_instance.py-server.public_ip}:443" 
# }
