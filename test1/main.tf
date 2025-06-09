resource "aws_instance" "abhi" {
  ami           = var.ami
  instance_type = "t2.micro"
  tags = {
    Name = "test"
  }

}
