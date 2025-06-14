# resource "aws_vpc" "myvpc" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "sub1" {
#   cidr_block = "10.0.1.0/16"
#   vpc_id     = aws_vpc.myvpc.id
# }

# resource "aws_subnet" "sub2" {
#   cidr_block = "10.0.2.0/16"
#   vpc_id     = aws_vpc.myvpc.id
# }
