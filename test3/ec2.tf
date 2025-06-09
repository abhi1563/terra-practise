resource "aws_instance" "name" {
  ami               = "ami-0953476d60561c955"
  instance_type     = "t2.small"
  availability_zone = "us-east-1b"
  tags = {
    Name = "abhi3"
  }

}
