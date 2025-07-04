terraform {
            required_providers {
            aws = {
          source = "hashicorp/aws"
        version = "~> 6.0"
      }
    }
    required_version = "~> 1.12.2"
  }
provider "aws" {
  region = "ap-south-1" # Change to your preferred region
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "abhi-VPC"
  }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true

    tags = {
          name = "abhi-subnet"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "abhi-IGW"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "PublicRouteTable-abhi"
     }
}

resource "aws_route_table_association" "rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg-abhi"
  description = "Allow SSH"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2SG-abhi"
  }
}
resource "aws_instance" "web" {

  ami           = "ami-03bb6d83c60fc5f7c" # Amazon Linux 2 (for ap-south-1)
  instance_type = "t2.micro"
  #public_ip = var.ec2_public_ip
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name = var.key_name

  # Replace with your existing EC2 key pair

   tags = {
   Name = "abhi-terraform" 
   }
}
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
