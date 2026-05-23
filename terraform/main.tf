resource "aws_vpc" "virtual_network" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.virtual_network.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.virtual_network.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.virtual_network.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "ecommerce_sg" {
  name   = "ecommerce-sg"
  vpc_id = aws_vpc.virtual_network.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Frontend"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Backend"
    from_port   = 3001
    to_port     = 3004
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow All Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ecommerce_instance" {
  ami             = "ami-05cf1e9f73fbad2e2" # Ubuntu Server 24.04 LTS
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.ecommerce_sg.id]
  key_name        = var.key_pair_name
  user_data       = <<-EOF
                #!/bin/bash
                apt update -y
                apt install docker.io -y
                systemctl start docker
                usermod -aG docker ubuntu
                docker network create ecommerce-network
                docker pull gowthamtanneeru/ecommerce_app:user-service
                docker pull gowthamtanneeru/ecommerce_app:product-service
                docker pull gowthamtanneeru/ecommerce_app:cart-service
                docker pull gowthamtanneeru/ecommerce_app:order-service
                docker pull gowthamtanneeru/ecommerce_app:frontend

                docker run -d \
                --name user-service \
                --network ecommerce-network \
                -p 3001:3001 \
                gowthamtanneeru/ecommerce_app:user-service

                docker run -d \
                --name product-service \
                --network ecommerce-network \
                -p 3002:3002 \
                gowthamtanneeru/ecommerce_app:product-service

                docker run -d \
                --name cart-service \
                --network ecommerce-network \
                -p 3003:3003 \
                gowthamtanneeru/ecommerce_app:cart-service

                docker run -d \
                --name order-service \
                --network ecommerce-network \
                -p 3004:3004 \
                gowthamtanneeru/ecommerce_app:order-service

                docker run -d \
                --name frontend \
                --network ecommerce-network \
                -p 3000:3000 \
                gowthamtanneeru/ecommerce_app:frontend

                EOF
}