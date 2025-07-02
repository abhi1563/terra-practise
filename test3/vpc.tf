#create vpc
resource "aws_vpc" "newvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "newvpc"
  }
  enable_dns_support   = true     # <--- must be true
  enable_dns_hostnames = true     # <--- must be true

}
#IG
resource "aws_internet_gateway" "myig" {
  vpc_id = aws_vpc.newvpc.id
}
#subnets
resource "aws_subnet" "sub1" {
  vpc_id            = aws_vpc.newvpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1b"
}
resource "aws_subnet" "pvt" {
  vpc_id     = aws_vpc.newvpc.id
  cidr_block = "10.0.1.0/24"
}
resource "aws_subnet" "db-sub" {
  vpc_id            = aws_vpc.newvpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1d"
}


#route table#edit routes
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.newvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myig.id
  }
}
#subnet association
resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.name.id
}

#create SG
resource "aws_security_group" "mysg-abhi" {
  name   = "mysg-abhi"
  vpc_id = aws_vpc.newvpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "tls_private_key" "abhi" {
  algorithm = "RSA"
  rsa_bits  = 4096

}

resource "aws_key_pair" "my_keypair" {
  key_name   = "my-ec2-keypair"
  public_key = tls_private_key.abhi.public_key_openssh

}

resource "local_file" "private_key" {
  content         = tls_private_key.abhi.private_key_openssh
  filename        = "${path.module}/my-ec2-keypair.pem"
  file_permission = "0400"
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [content]
  }
}
#Launch server
resource "aws_instance" "name" {
  ami                         = "ami-0953476d60561c955"
  instance_type               = "t2.small"
  subnet_id                   = aws_subnet.sub1.id
  availability_zone           = "us-east-1b"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my_keypair.key_name
  vpc_security_group_ids      = [aws_security_group.mysg-abhi.id]
  tags = {
    Name = "windows"
  }


}
