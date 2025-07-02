module "mynewmodule" {
  source         = "../test4"
  ami            = "ami-05ffe3c48a9991133"
  insstance_type = var.aws_instance
  bucket-name    = "afafafafafafafaf"

}
