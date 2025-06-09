terraform {
  backend "s3" {
    bucket = "abhinareshitnever"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
