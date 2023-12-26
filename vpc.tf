provider "aws"{
    region = "ap-south-1"
    alias = "env"
}
resource "aws_vpc" "demo_vpc"{
    cidr_block = "10.10.0.0/16"
    tags = {
        Name : "demo_vpc"
    }
}

resource "aws_subnet" "pub-subnet" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_security_group" "demo_sg" {
    name = "demo-vpc-sg"
    vpc_id = aws_vpc.demo_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.demo_vpc.cidr_block]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}