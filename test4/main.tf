resource "aws_instance" "myaws" {
  ami           = var.ami
  instance_type = var.insstance_type
}
