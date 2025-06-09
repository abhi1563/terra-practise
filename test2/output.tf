output "ipaddress" {
  value     = aws_instance.name.private_ip
  sensitive = true
}

output "name" {
  value = aws_s3_bucket.test.bucket
}
